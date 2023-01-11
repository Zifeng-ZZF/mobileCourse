# Introduction
This is an iOS file manager app that allows you to browse files in locol storage, iCloud and Box. You can download files from those sources and manage them centrally. It supports open of different types of files including txt, doc, ppt, excel, pdf, audio and video. It also supports functions such as sorting, filtering, and searching.

# Guide
You can run it from Xcode on iphone 11 Pro Max or coresponding simulator.

Environment Setting (Box APIs)
This Project has used some Box APIs. If you can not run the app in any case, try to build it for another time. If still not working, check if the Box Swift Package has been successfully imported. 
Here is how to import Box Swift Package:
1.In your Xcode project, click on the name of your application at the top of the project navigator on the left. In the content that displays, click on the name of your project under the PROJECT option.
2.Click on Swift Packages and click on the + to add a package.
3.Enter the following repository URL https://github.com/box/box-ios-sdk.git and click next.
4.Leave the default settings and click next to finish importing.




<strong>Note</strong>: if you try to launch the app from Xcode, make sure you delete the previous build first or there might be some problem opening the files. Or, if you would like to run the app again, make sure you run it by clicking the app icon directly.

## Browsing & Navigating
You will be presented the Main View once you enter the app. In the tableView, you may tap on any directories and tap on the back button on the navigation bar to browse the files added by you from different sources.

![create&delete](https://raw.githubusercontent.com/Zifeng-ZZF/gifs/master/564proj/images/browsing.gif)

## Open different files 
Prompt different options for openning / sharing a file according to its file types / url

![create&delete](https://raw.githubusercontent.com/Zifeng-ZZF/gifs/master/564proj/images/opening.gif)

## Adding files from differrent sources
There are three sources where we can add files from: 
<ol>
  <li>Files</li>
  <li>iCloud</li>
  <li>BOX</li>
</ol>
For Files, we will pick from local storage. For iCloud, we will be accessing the current iCloud account on the device. For BOX, we use OAuth 2.0 for authentication. Once logged in, the files and directories will be directly listed.

![create&delete](https://raw.githubusercontent.com/Zifeng-ZZF/gifs/master/564proj/images/add_from_source.gif)

## Creating/deleting a file/directory

You can create a folder with your chosen name using the add button. You delete file & directory by swiping the table entry to the left, and click on the shown delete bottom.

![create&delete](https://raw.githubusercontent.com/Zifeng-ZZF/gifs/master/564proj/images/add_delete.gif)


## Searching files in the all directories
The app also supports fuzzy search in the whole space.

![create&delete](https://raw.githubusercontent.com/Zifeng-ZZF/gifs/master/564proj/images/searching2.gif)

## Filtering files by their types
The app allows users to filter files in the current directories by their types. The resutls will be displayed in the new window when users can directly open files from.

![create&delete](https://raw.githubusercontent.com/Zifeng-ZZF/gifs/master/564proj/images/filtering.gif)

## Sorting files and directories under current directory
Files & directories under the current directory can be sorted ascendingly by names, types, and create dates.

![create&delete](https://raw.githubusercontent.com/Zifeng-ZZF/gifs/master/564proj/images/sorting.gif)

# References
File types icon pngs are from: 
- https://www.iconpacks.net/free-icon/text-1473.html
- https://www.iconfont.cn

Box Package Setting / API from 
- https://developer.box.com/guides/mobile/ios/quick-start/install-ios-sdk/
- https://developer.box.com/reference/

