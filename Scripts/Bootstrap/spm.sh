#!/bin/sh

readonly arguments=$@
readonly script_path="$( cd "$( dirname "$0" )" && pwd )"

source "${script_path}/common.sh"

if [[ "$(uname -m)" == "arm64" ]]; then
  eval "$(/opt/homebrew/bin/brew shellenv)"
fi

echo "Resolving ${swift_style}Swift packages${default_style} specified in Package.swift..."
assert_failure '(cd "${root_path}" && swift package resolve)'

echo ""
