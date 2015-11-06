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
xcrun -log -sdk iphoneos PackageApplication "$OUTPUTDIR/$APPNAME.app" -o "$OUTPUTDIR/$APPNAME.ipa" -sign "$DEVELOPER_NAME" -embed "$PROVISIONING_PROFILE"

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

echo "Testing with @"
./Pods/Crashlytics/Crashlytics.framework/submit "$API_KEY" "$BUILD_SECRET" -ipaPath "@$OUTPUTDIR/$APPNAME.ipa" -emails jbala87@gmail.com
echo "Testing without @"
./Pods/Crashlytics/Crashlytics.framework/submit "$API_KEY" "$BUILD_SECRET" -ipaPath "$OUTPUTDIR/$APPNAME.ipa" -emails jbala87@gmail.com
