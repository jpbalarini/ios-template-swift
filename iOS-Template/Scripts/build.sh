#!/bin/sh
# xcodebuild -workspace iOS-Template.xcworkspace -scheme Production -sdk iphoneos -configuration Release OBJROOT=$PWD/build SYMROOT=$PWD/build ONLY_ACTIVE_ARCH=NO CODE_SIGN_IDENTITY="" CODE_SIGNING_REQUIRED=NO | xcpretty -c && exit ${PIPESTATUS[0]}
export PATH_TO_KEYCHAIN="~/Library/Keychains/ios-build.keychain"
xctool -workspace iOS-Template.xcworkspace -scheme 'Production' -configuration Release -sdk iphoneos CONFIGURATION_BUILD_DIR='~/build/' CODE_SIGN_IDENTITY="iPhone Distribution: Juan Balarini (5U87XMD88S)" PROVISIONING_PROFILE='81e6a777-675d-4938-9c04-05615042bb88' "OTHER_CODE_SIGN_FLAGS=--keychain '$PATH_TO_KEYCHAIN'" build
