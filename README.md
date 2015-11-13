# iOS Template Swift

iOS Swift template application.

## Get started

To setup project please follow the next steps:
 1. [Download](#download).
 2. [Rename project](#rename-project).
 3. [Configure mogenerator](#configure-mogenerator).
 4. [Configure CocoaPods](#configure-cocoapods).
 5. [Configure Fabric/Crashlytics](#configure-fabric-crashlytics).
 6. [Configure HockeyApp](#configure-hockeyApp).
 7. [Configure TravisCI](#configure-travisCI).
 8. [Edit README.md](#edit-readme-md).
 9. [Commit and push to repository](#made-initial-commit-and-push-to-remote-repository).

### Clone or download

First, dowload the project as a zip file to keep commit history clean.

Then, you should init the Git repository:
```sh
cd Path/To/ios-template
git init
git remote add origin git@github.com:user/some-git-repository.git
```

### Rename project
To rename the project you should:

#### Change project name:
* Run the .rename_project.sh script. Enter the new project name
* Open the .workspace project
* In the Project Navigator on the left side, click twice slowly on the project name and it will become editable. Type the new name. A dialog will appear listing all the items Xcode suggests to be renamed.
* Click Rename.

#### Remove mentions in code:
* Open search tab in the Project Navigator on the left side of Xcode.
* Search ```iOS-Template``` in project.
* Replace any occurrence of the iOS-Template name with the new project name.

#### Change bundle id:
* Change bundle id for all schemes in project build settings.

#### Change workspace reference:
* Right click the project bundle .workspace file and select “Show Package Contents” from the context menu. Open the .xcworkspacedata file with any text editor.
* Change the absolute route:

```
group:/Users/something/../ProjectName.xcodeproj
```
to a relative path

```
group:ProjectName.xcodeproj
```

### Configure mogenerator
* Go to Build Rules.
* Change path to script in  ```Data model files using Script```.
* Change path to script in  ```Data model version files using Script```.

### Configure CocoaPods
* Find Podfile in project.
* Uncomment, add or remove pods.

* Then run in terminal:

```sh
pod install
```

### Configure Fabric/Crashlytics
* Check bundle id in project build settings for all schemes.
* Install native Fabric app.
* Follow the provided steps on the Fabric app
* Be sure to set SBKeyAPIKeyCrashlitycs in Constants.swift and to add the Run Script.
* Create organization in Fabric/Crashlytics.
* Add applications to this organization for all schemes.
* Uncomment the Crashlytics.startWithAPIKey(SBKeyAPIKeyCrashlitycs) to register the app

### Configure HockeyApp
* Download the native HockeyApp app for Mac OS
* Install it and follow the provided steps there

### Configure TravisCI
* Check the .travis.yml file
* Replace iOS-Template with your project name
* Replace DEVELOPER_NAME with the correct distribution certificate name
* Change PROFILE_NAME with you Provisioning Profile name
* Export the following things from the Keychain app to the scripts/travis folder:
  1. "Apple Worldwide Developer Relations Certification Authority" into scripts/travis/apple.cer
  2. Your iPhone Distribution certificate into scripts/travis/dist.cer
  3. Your iPhone Distribution private key into scripts/travis/dist.p12 (choose a password)
* Use the travis encrypt command to encryp the following variables:

```sh
travis encrypt "KEY_PASSWORD=YOUR_KEY_PASSWORD" --add
travis encrypt HOCKEY_APP_ID=super_secret --add
travis encrypt HOCKEY_APP_TOKEN=super_secret --add
```

* Download your provisioning profile from the Apple Developer portal and copy it to scripts/travis/profile/

### Rename .xcdatamodeld
* Rename CoreData/iOS-Template.xcdatamodel


### Edit README.md
* Edit ```README.md```.

### Make initial commit and push to remote repository
```sh
cd Path/To/Project
git init
git add --all
git commit -m "Initial commit"
git remote add origin git@github.com:user/some-git-repository.git
git push origin master
```
