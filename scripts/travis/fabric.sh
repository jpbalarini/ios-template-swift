#!/bin/sh
if [[ "$TRAVIS_PULL_REQUEST" != "false" ]]; then
  echo "This is a pull request. No deployment will be done."
  exit 0
fi
if [[ "$TRAVIS_BRANCH" != "master" ]]; then
  echo "Testing on a branch other than master. No deployment will be done."
  exit 0
fi

PROVISIONING_PROFILE="$HOME/Library/MobileDevice/Provisioning Profiles/$PROFILE_UUID.mobileprovision"
RELEASE_DATE=`date '+%Y-%m-%d %H:%M:%S'`
OUTPUTDIR="/Users/travis/build"


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

# # Create an archive
# xcodebuild -alltargets -configuration Release -scheme 'Production' -archivePath "$OUTPUTDIR/$APPNAME.xcarchive" archive
# # Create the IPA file from the archive
# xcodebuild -exportProvisioningProfile "$PROFILE_UUID" -exportArchive -exportFormat IPA -archivePath "$OUTPUTDIR/$APPNAME.xcarchive" -exportPath "$OUTPUTDIR/$APPNAME.ipa" CODE_SIGN_IDENTITY="$DEVELOPER_NAME"



RELEASE_NOTES="Build: $TRAVIS_BUILD_NUMBER\nUploaded: $RELEASE_DATE"

zip -r -9 "$OUTPUTDIR/$APPNAME.app.dSYM.zip" "$OUTPUTDIR/$APPNAME.app.dSYM"

# IPA_SIZE=$(stat -c%s "$OUTPUTDIR/$APPNAME.ipa")
# echo "IPA $IPA_SIZE"
# DSYM_SIZE=$(stat -c%s "$OUTPUTDIR/$APPNAME.app.dSYM.zip")
# echo "DSYM $DSYM_SIZE"

echo "********************"
echo "*    Uploading     *"
echo "********************"
# curl http://testflightapp.com/api/builds.json \
#   -F file="@$OUTPUTDIR/$APPNAME.ipa" \
#   -F dsym="@$OUTPUTDIR/$APPNAME.app.dSYM.zip" \
#   -F api_token="$API_TOKEN" \
#   -F team_token="$TEAM_TOKEN" \
#   -F distribution_lists='Internal' \
#   -F notes="$RELEASE_NOTES" -vs

# ./Pods/Crashlytics/Crashlytics.framework/submit "$API_KEY" "$BUILD_SECRET" -ipaPath "$OUTPUTDIR/$APPNAME.ipa" -emails jbala87@gmail.com -debug YES

curl https://rink.hockeyapp.net/api/2/apps/$HOCKEY_APP_ID/app_versions \
  -F status="2" \
  -F notify="0" \
  -F notes="$RELEASE_NOTES" \
  -F notes_type="0" \
  -F ipa="@$OUTPUTDIR/$APP_NAME.ipa" \
  -F dsym="@$OUTPUTDIR/$APP_NAME.app.dSYM.zip" \
  -H "X-HockeyAppToken: $HOCKEY_APP_TOKEN"
