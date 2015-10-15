# iOS Template Swift

iOS Swift template application.

## Get started

To setup project follow a few simple steps:
 1. [Download](#download).
 2. [Rename project](#rename-project).
 3. [Configure mogenerator](#configure-mogenerator).
 4. [Configure CocoaPods](#configure-cocoapods).
 5. [Configure Fabrick/Crashlytics](#configure-fabric-crashlytics).
 6. [Edit README.md](#edit-readme-md).
 7. [Commit and push to repository](#made-initial-commit-and-push-to-remote-repository).

### Clone or download

First, dowload the project as a zip file to keep commit history clean.

Then, you should init the Git repository:
```sh
cd Path/To/ios-template
git init
git remote add origin git@github.com:user/some-git-repository.git
```

### Rename project
To rename project you should:

#### Change project name:
* In the Project Navigator on the left side, click twice slowly on the project name and it will become editable. Type the new name. A dialog will appear listing all the items Xcode suggests to be renamed.
* Click Rename.

#### Remove mentions in code:
* Open search tab in the Project Navigator on the left side of Xcode.
* Search ```iOS-Template``` in project.
* Replace any occurrence of the iOS-Template name with the new project name.

#### Change folders names:
* Go to the project directory and rename folders ```iOS-Template```, ```iOS-TemplateTests```.
* Rename ```iOS-TemplateTests.swift``` in folder for test classes.

#### Change .xcodeproj file:
* Right click the project bundle ```.xcodeproj``` file and select “Show Package Contents” from the context menu. Open the ```.pbxproj``` file with any text editor.
* Search and replace any occurrence of the ```swift-base``` with the new project name.
* Save the file.

#### Change bundle id:
* Change bundle id for all schemes in project build settings.

#### Rename workspace:
* Simple rename ```iOS-Template.xcworkspace``` with new project name.

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

### Rename .xcdatamodeld
* Rename CoreData/iOS-Template.xcdatamodel


### Edit README.md
* Edit ```README.md```.

### Made initial commit and push to remote repository
```sh
cd Path/To/Project
git init
git add --all
git commit -m "Initial commit"
git remote add origin git@github.com:user/some-git-repository.git
git push origin master
```
