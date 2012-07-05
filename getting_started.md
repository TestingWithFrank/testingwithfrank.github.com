---
layout: default
title: Installing Frank
---

## Frankifying your app and writing your first test

Pete Hodgson has an article called ["Writing Your First Frank Test"](http://blog.thepete.net/blog/2012/06/24/writing-your-first-frank-test/) which should cover all the steps you need to get started with Frank.

If you're the kind of person who prefers to watch rather than read then check out [this 5 minute screencast](https://vimeo.com/44224224) which demonstrates all the steps needed to get started by Frankifying your app.

## Turn on Accessibility in OS X

In addition to the steps outlined in that article you will need to turn on the accessibility features on the machine hosting your iOS simulator.  Frank leverages accessibility to automate some actions with the simulator (such as rotating the device).

On the machine which will be hosting the iOS Simulator go to System Preferences -> Universal Access
and Check “Enable access for assistive devices”.
![Universal Access Screenshot](images/screenshots/mac-universal-access.png)
