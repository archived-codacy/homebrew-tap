#!/usr/bin/env bash

#
# Update the Formula version
#
# Requirements:
# * git
# * curl
# * shasum (with 256 algorithm)
# * sed
#

set -e

if [ -z "$1" ] && [ -z "$2" ]; then
  echo "usage: $0 <formula> <VERSION>" >&2
  exit 1
fi

formula="$1"
formula_path="Formula/${1}.rb"
version="$2"

sha256=$(curl -sL "https://github.com/codacy/${formula}/archive/v$version.tar.gz" | shasum -a256 | cut -d " " -f 1)

git checkout master
git pull

sed 's/^\(.*\/v\).*\(.tar.gz"\)$/\1'"$version"'\2/' "$formula_path"
> "$formula_path.modified"
sed 's/^\(.*sha256 "\).*\(".*\)$/\1'"$sha256"'\2/' "$formula_path.modified"
> "$formula_path"
rm "$formula_path.modified"

git add "$formula_path"
git commit -m "Release v$version"
git show
git push
