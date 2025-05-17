#!/bin/sh

set -e

readonly helpers_path="$( cd "$( dirname "$0" )" && pwd )/Helpers"

readonly derived_data_path="DerivedData"
readonly documentation_path="Documentation"
readonly docarchive_path="${derived_data_path}/Build/Products/Release-iphonesimulator/RafinadDocumentation.doccarchive"
readonly hosting_base_path="Rafinad"

readonly project="Rafinad.xcodeproj"
readonly scheme="Rafinad Documentation"
readonly destination="platform=iOS Simulator,name=iPhone 16"

source "${helpers_path}/script-paths.sh"

cd $root_path

xcodebuild clean docbuild \
  -project "${project}" \
  -scheme "${scheme}" \
  -configuration "RELEASE" \
  -derivedDataPath "${derived_data_path}" \
  -destination "${destination}"

rm -rf "${documentation_path}"

$(xcrun --find docc) process-archive \
  transform-for-static-hosting "${docarchive_path}" \
  --output-path "${documentation_path}" \
  --hosting-base-path "${hosting_base_path}"

rm -rf "${derived_data_path}"
