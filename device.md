---
layout: default
title: Testing using a physical device
---

*As described on [this](https://groups.google.com/d/msg/frank-discuss/GHgxxJWAs4I/LvEBlQ6VGp4J) mailing list thread*


#STEP 1: build frankified app from command line

You can use xcodebuild on the command line to do this.  If you have multiple targets, you have to specify the target to build (or schemes if you have a workspace).   The default frank build command builds only for the simulator.  This build command will leave you with a binary `app_name.app` in your frankified_build directory; and it is the frankified app.

    xcodebuild \
    -target <app_target (optional, if you have only one)> \
    -xcconfig ./Frank/frankify.xcconfig \
    -arch armv7 \
    -configuration Debug \
    -sdk iphoneos \
    DEPLOYMENT_LOCATION=YES \
    DSTROOT="<full_path_to_your_xcode_project_directory>/Frank/frankified_build" \
    FRANK_LIBRARY_SEARCH_PATHS="<full_path_to_your_xcode_project_directory>/Frank" \
    clean build

<p>&nbsp;</p>

#STEP 2: build and run fruitstrap
Fruitstrap will install the app to the device and launch it using gdb. Make sure your provisioning includes your device or it will fail on the verification step; and that you have proper code-signing certs in your Xcode.  Delete your previous build first to verify that it actually loaded.

Preparation:
symlink: /Users/[user_dir_name]/Library/Developer/Xcode/iOS DeviceSupport/6.1.x (xxx)/DeveloperDiskImage.dmg from 
		 /Applications/Xcode.app/Contents/Developer/Platforms/iPhoneOS.platform/DeviceSupport/6.1 (10B141)/DeveloperDiskImage.dmg

symlink: /Users/[user_dir_name]/Library/Developer/Xcode/iOS DeviceSupport/6.0.x (xxx)/DeveloperDiskImage.dmg from 
		 /Applications/Xcode.app/Contents/Developer/Platforms/iPhoneOS.platform/DeviceSupport/6.0/DeveloperDiskImage.dmg
		
symlink: /Users/[user_dir_name]/Library/Developer/Xcode/iOS DeviceSupport/5.1.x (xxx)/DeveloperDiskImage.dmg from 
		 /Applications/Xcode.app/Contents/Developer/Platforms/iPhoneOS.platform/DeviceSupport/5.1/DeveloperDiskImage.dmg

symlink: /Users/[user_dir_name]/Library/Developer/Xcode/iOS DeviceSupport/5.0.x (xxx)/DeveloperDiskImage.dmg from 
		 /Applications/Xcode.app/Contents/Developer/Platforms/iPhoneOS.platform/DeviceSupport/5.0/DeveloperDiskImage.dmg

symlink: /Users/[user_dir_name]/Library/Developer/Xcode/iOS DeviceSupport/4.3.x (xxx)/DeveloperDiskImage.dmg from 
		 /Applications/Xcode.app/Contents/Developer/Platforms/iPhoneOS.platform/DeviceSupport/4.3/DeveloperDiskImage.dmg

## Get my fork of fruitstrap (I had to patch the default path for gdb)

    git clone git://github.com/ekbiker/fruitstrap.git

## Build and run fruitstrap

    cd fruitstrap
    make fruitstrap
    ./fruitstrap -d -b [full_path_to_your_xcode_project_directory]/Frank/frankified_build/[app_name].app


<p>&nbsp;</p>
# STEP 3: run cucumber
In your env.rb you have to tell it to use the physical device.  Look in the Controls example app in the Frank Repo for how to do that. 

    ... cd to your Frank directory
    cucumber

hopefully, If everything worked, you will see...

    finding Frank server via Bonjour...
    ...found Frank via Bonjour: 192.168.1.116

Or, in your console logs you will see the bonjour port the Frank Sever is now bound to...


THATS IT! 

## Here's a shell script that will build and run in one step

    #!/bin/bash

    # Exit on errors
    set -e

    # Set paths
    xcode_proj_path= <xcode_proj_path>
    app_name=<app_name>
    build_target=<build_target>

    # Build frankified app
    xcodebuild \
    -target ${build_target} \
    -xcconfig ./Frank/frankify.xcconfig \
    -arch armv7 \
    -configuration Debug \
    -sdk iphoneos \
    DEPLOYMENT_LOCATION=YES \
    DSTROOT="${xcode_proj_path}/Frank/frankified_build" \
    FRANK_LIBRARY_SEARCH_PATHS="${xcode_proj_path}/Frank" \
    clean build

    # Use fruitstrap as a means to install and run the app
    ./fruitstrap -d -b ${xcode_proj_path}/Frank/frankified_build/${app_name}.app

