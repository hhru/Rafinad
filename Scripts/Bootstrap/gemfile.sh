#!/bin/sh

readonly arguments=$@
readonly script_path="$( cd "$( dirname "$0" )" && pwd )"

source "${script_path}/common.sh"

readonly shell_all_local_line="export LC_ALL=en_US.UTF-8"
readonly shell_default_local_line="export LANG=en_US.UTF-8"

setup_shell() {
  local shell_profile_path=$1

  if [[ ! -f "${shell_profile_path}" ]]; then
    > "${shell_profile_path}"
  fi

  if [[ $(grep -L "^${shell_all_local_line}" "${shell_profile_path}") ]]; then
    echo "${shell_all_local_line}" >> "${shell_profile_path}"
  fi

  if [[ $(grep -L "^${shell_default_local_line}" "${shell_profile_path}") ]]; then
    echo "${shell_default_local_line}" >> "${shell_profile_path}"
  fi
}

if [[ "$(uname -m)" == "arm64" ]]; then
  eval "$(/opt/homebrew/bin/brew shellenv)"
fi

eval "$(rbenv init -)"

export SDKROOT=$(xcrun --sdk macosx --show-sdk-path)

if [[ " ${arguments[*]} " == *" ${update_flag} "* ]]; then
  echo "Updating ${ruby_style}Ruby gems${default_style} specified in Gemfile..."
  assert_failure '(cd "${root_path}" && bundle update)'
else
  echo "Installing ${ruby_style}Ruby gems${default_style} specified in Gemfile..."
  assert_failure '(cd "${root_path}" && bundle install)'
fi

setup_shell "${HOME}/.zshrc"

echo ""
