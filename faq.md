---
layout: default
title: Frequently Asked Questions
---

In an unusual twist, these are actually questions that are frequently
asked on the [frank-discuss mailing list](mailing_lists.html)!

## Can I use Frank to test an app that I haven't built myself?

No sorry. In order to test an application with Frank you need to
compile or link the Frank server into the application you are testing.

## Can I use Frank to test web-based apps?
If you want to test a pure web app (no native code at all) then Frank can't help you, but [the WebDriver project's iPhoneDriver](http://code.google.com/p/selenium/wiki/IPhoneDriver) is a good option. If you have a hybrid app (a Native app which uses web views to implement some of the UI) then Frank does have some functionality to inspect the state of a web view, and evaluate javacript, but it's fairly basic for now.

## Can I use Frank to test RubyMotion apps?
You sure can! [Here's a handy blog post](http://calebcohoon.blogspot.com.au/2012/06/test-rubymotion-apps-using-cucumber.html) to get you started.

## Can I use Frank to test MonoTouch apps?
You sure can! [Here's a handy blog post](http://www.alejandrobeiderman.com/2012/11/setting-up-frank-with-monotouch/) to get you started.

## Can I use Frank to execute arbitrary code in my app as part of a test?

Yes. Frank exposes an [app_exec](http://rdoc.info/github/moredip/Frank/Frank/Cucumber/FrankHelper#app_exec-instance_method) command which you can use to execute
any method which your app delegate implements.

## Can I automate a physical device using Frank.

Yes, people have this working, but it hasn't been documented very well. Ask on the [mailing list](mailing_lists.html) for more details.


## How can I automate filling out a text field using the keyboard?
Recent releases of Frank have a [type_into_keyboard](http://rdoc.info/github/moredip/Frank/Frank/Cucumber/KeyboardHelper#type_into_keyboard-instance_method) method.


## How should I set up this APP_BUNDLE_PATH thing that Frank is complaining to me about?

If you're using `frank setup` and `frank build` then you shouldn't have to worry about APP_BUNDLE_PATH at all - the default value should be set correctly.
If you're setting up your Frankified build by hand then you do need to set up your APP_BUNDLE_PATH as part of that.

You need to set APP_BUNDLE_PATH to point to the location of your Frankified app bundle (the directory that ends in .app).
One easy approach is to generate a file containing the APP_BUNDLE_PATH as part of your Frankified xcode build. 
Specifically, you can add a 'run script' build step to your Xcode target's build setup which contains:

`echo APP_BUNDLE_PATH=\"$BUILT_PRODUCTS_DIR/$EXECUTABLE_NAME.app\" > $SRCROOT/Frank/features/support/bundle_path.rb`

That generates a support/bundle_path.rb file ever time you build which sets APP_BUNDLE_PATH to the location of the app bundle which XCode just built. 
Cucumber will by default automagically import anything in that support dir, so it will load that file and make the valid_APP_BUNDLE_PATH value for Frank to use.
