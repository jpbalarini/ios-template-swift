#!/bin/sh

xctool -workspace iOS-Template.xcworkspace -scheme 'Production' -configuration Release -sdk iphoneos CONFIGURATION_BUILD_DIR='~/build/' build
