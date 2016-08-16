#!/bin/bash
# release.sh

set -x # verbose loggging with variable expansion
set -e # switch ON exit on errors

cleanup() {
	echo "Script exitted with code $?"	
}
trap "cleanup" EXIT

NEW_APP_VERSION=$1
PODSPEC=$2
SPECS_REPO=$3

# Check for missing app version
if [[ $# -eq 0 ]]; then
    echo "Usage: $0 <new app version> <path to podspec> <spec repo name>" >&2
    exit 1
fi

# Allows only 1-3 digit semantic versioning strings
if [[ ! $NEW_APP_VERSION =~ ^([0-9]+\.){1,2}([0-9]+)$ ]]; then
    echo "Permitted version formats: $0 1.2.3 ./FrameworkName.podspec flinc-specs || $0 1.2 ./FrameworkName.podspec SpecRepoName" >&2
    exit 1
fi

# Check for file existence
if [[ ! -e "$PODSPEC" ]]; then
  echo "Podspec file $PODSPEC does not exist!"
  exit 1
fi

# Check if podspec repo exists
if [[ ! -d "${HOME}/.cocoapods/repos/${SPECS_REPO}" ]]; then
  echo "Pod repo $SPECS_REPO does not exist!"
  exit 1
fi

# Check if the app builds
pod lib lint --allow-warnings

# Update podspec version - rplace in place (-i) create NO backup file ('')
CURRENT_VERSION=$(sed -n '/\(s.version *= *\)/ p' $PODSPEC | awk -F\' '{print $2}')
sed -i '' -e "s/$CURRENT_VERSION/$NEW_APP_VERSION/g" "$PODSPEC"

# Command chain I
git add "$PODSPEC" && git commit -m "Release $NEW_APP_VERSION" && git tag -f "$NEW_APP_VERSION" && git push

# Opt out of exit on fail - git push --tag sometimes returns non-zero exit state but successfully pushed the new tag
set +e

# Command chain II
git push --tag

# Opt in again to exit on error
set -e

# Command chain III
pod repo push "$SPECS_REPO" "$PODSPEC" --allow-warnings