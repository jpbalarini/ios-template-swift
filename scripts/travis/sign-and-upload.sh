#!/bin/sh
if [[ "$TRAVIS_PULL_REQUEST" != "false" ]]; then
  echo "This is a pull request. No deployment will be done."
  exit 0
fi
# Only deploy develop
if [[ "$TRAVIS_BRANCH" != "develop" ]]; then
  echo "Testing on a branch other than develop. No deployment will be done."
  exit 0
fi

PROVISIONING_PROFILE="$HOME/Library/MobileDevice/Provisioning Profiles/$PROFILE_NAME.mobileprovision"
RELEASE_DATE=`date '+%Y-%m-%d %H:%M:%S %z'`
OUTPUTDIR="/Users/travis/build"
VERSION_NUMBER=$(/usr/libexec/PlistBuddy -c "Print CFBundleShortVersionString" "./$APPNAME/Info.plist")
BUILD_NUMBER=$(/usr/libexec/PlistBuddy -c "Print CFBundleVersion" "./$APPNAME/Info.plist")

echo "********************"
echo "*     Signing      *"
echo "********************"

# Fix for bug in XCODE7
sed -i -e 's/--preserve-metadata=identifier,entitlements,resource-rules/--preserve-metadata=identifier,entitlements/g' /Applications/Xcode.app/Contents/Developer/Platforms/iPhoneOS.platform/Developer/usr/bin/PackageApplication
sed -i -e 's/\"--sign\",\ $opt{sign},/\"--sign\",\ $opt{sign});/g' /Applications/Xcode.app/Contents/Developer/Platforms/iPhoneOS.platform/Developer/usr/bin/PackageApplication
sed -i -e 's/\"--resource-rules=$destApp\/ResourceRules.plist\");//g' /Applications/Xcode.app/Contents/Developer/Platforms/iPhoneOS.platform/Developer/usr/bin/PackageApplication

BUILD_DIR_CONTENTS="$(ls /Users/travis/build)"
echo "${BUILD_DIR_CONTENTS}"
# Create IPA
xcrun -log -sdk iphoneos PackageApplication -v "$OUTPUTDIR/$APPNAME.app" -o "$OUTPUTDIR/$APPNAME.ipa" -sign "$DEVELOPER_NAME" -embed "$PROVISIONING_PROFILE" CODE_SIGN_RESOURCE_RULES_PATH='$(SDKROOT)/ResourceRules.plist'


RELEASE_NOTES="Build: $VERSION_NUMBER ($BUILD_NUMBER) - Uploaded: $RELEASE_DATE"

zip -r -9 "$OUTPUTDIR/$APPNAME.app.dSYM.zip" "$OUTPUTDIR/$APPNAME.app.dSYM"

IPA_SIZE=$(stat -c%s "$OUTPUTDIR/$APPNAME.ipa")
echo "IPA Size: $IPA_SIZE"
DSYM_SIZE=$(stat -c%s "$OUTPUTDIR/$APPNAME.app.dSYM.zip")
echo "DSYM Size: $DSYM_SIZE"

echo "********************"
echo "*    Uploading     *"
echo "********************"
# Testflight upload
# curl http://testflightapp.com/api/builds.json \
#   -F file="@$OUTPUTDIR/$APPNAME.ipa" \
#   -F dsym="@$OUTPUTDIR/$APPNAME.app.dSYM.zip" \
#   -F api_token="$API_TOKEN" \
#   -F team_token="$TEAM_TOKEN" \
#   -F distribution_lists='Internal' \
#   -F notes="$RELEASE_NOTES" -vs

# Crashlytics upload
# ./Pods/Crashlytics/Crashlytics.framework/submit "$API_KEY" "$BUILD_SECRET" -ipaPath "$OUTPUTDIR/$APPNAME.ipa" -emails some@email.com -debug YES

# Hockeyapp upload
response=$(curl https://rink.hockeyapp.net/api/2/apps/$HOCKEY_APP_ID/app_versions \
  -F status="2" \
  -F notify="1" \
  -F notes="$RELEASE_NOTES" \
  -F notes_type="0" \
  -F ipa="@/Users/travis/build/iOS-Template.ipa" \
  -F dsym="@/Users/travis/build/iOS-Template.app.dSYM.zip" \
  -H "X-HockeyAppToken: $HOCKEY_APP_TOKEN")
echo $response
