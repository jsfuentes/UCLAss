# UClass

IOS app to find classes happening at UCLA right now and the inverse, empty classrooms. 

## Running
Are you on a mac with xcode installed? Cuz you need to be

Clone or download the repo
If you don't have CocoaPods installed, run `sudo gem install cocoapods`
In the UClass directory run `pod install`
Open the project workspace(not the project file)
For best results, change simulation phone to Iphone6
Run the project

Use line 32 in ClassViewController.swift to select the date time you want to search for, defaults to now 

## Fixing it
This will break in Spring 2018 because it doesn't autodetect the quarter. Just change line
187 in ClassViewController.swift to the appropriate url for the current classes of the DevX API.
See api.ucladevx.com for the documentation.

