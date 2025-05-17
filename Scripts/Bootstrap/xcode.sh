#!/bin/sh

set -e

while [[ "$#" -gt 0 ]]; do
  case $1 in
    --sudo-password) sudo_password="${2}"; shift ;;
    *) echo "Unknown parameter passed: $1"; exit 1 ;;
  esac
  shift
done

if [ -n "${sudo_password}" ]; then
  echo "${sudo_password}" | sudo -S -E "$0"
  exit $?
fi

readonly script_path="$( cd "$( dirname "$0" )" && pwd )"

source "${script_path}/common.sh"

echo "Checking ${xcode_style}Xcode${default_style} installation:"

if [[ "$(uname -m)" == "arm64" ]]; then
  eval "$(/opt/homebrew/bin/brew shellenv)"
fi

readonly xcode_required_version=$(cat "${root_path}"/.xcode-version)
readonly xcode_installed_versions=($(xcodes installed 2>&1))

if [[ " ${xcode_installed_versions[@]} " =~ " ${xcode_required_version} " ]]; then
  readonly xcode_selected_version=$(xcodes installed 2>&1 | sed -n '/Selected/p')

  if [[ " ${xcode_selected_version} " =~ " ${xcode_required_version} " ]]; then
    echo "  Required Xcode version (${xcode_required_version}) already installed and selected."
  else
    echo "  Required Xcode version (${xcode_required_version}) already installed. Selecting..."
    assert_failure '(xcodes select "${xcode_required_version}")'
  fi
else
  echo "  Required Xcode version ($xcode_required_version) not found. Installing..."

  assert_failure 'xcodes update'

  if [ -n "${FASTLANE_SESSION}" ]; then
    xcodes install "${xcode_required_version}" --use-fastlane-auth
  else
    xcodes install "${xcode_required_version}"
  fi

  echo "  Selecting Xcode version..."
  assert_failure '(xcodes select "${xcode_required_version}")'

  echo "  Accepting license..."
  assert_failure '(sudo xcodebuild -license accept)'
fi

readonly xcode_runtime_required_version=$(cat "${root_path}"/.xcode-runtime-version)
readonly xcode_runtime_installed_versions=($(xcrun simctl runtime list 2>&1))

if [[ ! " ${xcode_runtime_installed_versions[@]} " =~ " ${xcode_runtime_required_version} " ]]; then
  echo "  Required Xcode runtime version (${xcode_runtime_required_version}) not found. Installing..."
  xcodes runtimes install "iOS ${xcode_runtime_required_version}"
else
  echo "  Required Xcode runtime version (${xcode_runtime_required_version}) already installed."
fi

echo ""
