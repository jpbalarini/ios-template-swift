#! /usr/bin/env bash

echo "Enter the new project name:"
read input_name
if [ "$input_name" == "" ]; then
  echo "You need to enter an input name"
  exit
fi
echo "The new project name will be: $input_name"

sed -i.bak 's/iOS-Template/'"$input_name"'/g' .travis.yml
sed -i.bak 's/iOS-Template/'"$input_name"'/g' Podfile
sed -i.bak 's/iOS-Template/'"$input_name"'/g' iOS-Template.xcodeproj/project.pbxproj
sed -i.bak 's/iOS-Template/'"$input_name"'/g' iOS-Template/Scripts/build.sh
sed -i.bak 's/iOS-Template/'"$input_name"'/g' iOS-Template/Scripts/mogend.sh
sed -i.bak 's/iOS-Template/'"$input_name"'/g' iOS-Template/Scripts/test.sh

# Remove all .DS_Store files
find . -name '*.DS_Store' -type f -delete
# Rename all files
find ./iOS-Template -type f -name "*.swift" -exec sed -i.bak 's/iOS-Template/'"$input_name"'/g' {} +
find ./iOS-TemplateTests -type f -name "*.swift" -exec sed -i.bak 's/iOS-Template/'"$input_name"'/g' {} +
find ./iOS-Template -type f -name "*.h" -exec sed -i.bak 's/iOS-Template/'"$input_name"'/g' {} +
find ./iOS-TemplateTests -type f -name "*.h" -exec sed -i.bak 's/iOS-Template/'"$input_name"'/g' {} +

mv -f ./iOS-TemplateTests/iOS-TemplateTests.swift ./iOS-TemplateTests/"$input_name"Tests.swift 2>/dev/null; true
mv -f iOS-Template "$input_name" 2>/dev/null; true
mv -f iOS-TemplateTests "$input_name"Tests 2>/dev/null; true
mv -f iOS-Template.xcworkspace "$input_name".xcworkspace 2>/dev/null; true

# Remove all .bak files
find . -name '*.bak' -type f -delete
