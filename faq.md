---
layout: default
title: Frequently Asked Questions
---

In an unusual twist, these are actually **questions** that are **frequently
asked** on the [frank-discuss mailing list](mailing_lists.html)!

## Can I use Frank to test an app that I haven't built myself?

No, sorry. In order to test an application with Frank you need to
compile or link the Frank server into the application you are testing.

## How can I debug my Frankified app in XCode

Aki Koskinen [posted this solution](https://groups.google.com/d/msg/frank-discuss/NlN7kb4iUB4/yKm_IV7MBRQJ) on the frank-discuss mailing list:

In this solution the Frankified application isn't built with Xcode so no changes are needed to any of the build settings of the project in Xcode. Instead the Frankified.app that 'frank build' makes is used directly. So the first step is to build your Frankified.app the usual way with 'frank build'.

Next, create a new scheme in Xcode. The "New Scheme..." item can be found from the "Product" menu for example. In the presented dialog choose "None" as the "Target" and give your scheme a name. Press OK.

In the next dialog make sure "Run" is selected in the left pane (it's probably selected by default) and the "Info" tab is selected in the center of the dialog. Choose "Other..." in the "Executable" dropdown and navigate to your Frankified.app and select it. If all goes well Xcode should now change the "Destination" selection in the upper part of the dialog to an iOS simulator of some kind. I just experienced a moment ago that Xcode didn't do this but restarting Xcode got it behaving again.

Basically this is all that is needed but you can off course tune other settings in the scheme as you wish. Press OK in the end.

Running the Frankified app is now as easy as selecting the newly created scheme and pressing the run button.


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

Yes. Read all about it [here](device.html).


## How can I automate filling out a text field using the keyboard?
Recent releases of Frank have a [type_into_keyboard](http://rdoc.info/github/moredip/Frank/Frank/Cucumber/KeyboardHelper#type_into_keyboard-instance_method) method.

## My tests are failing to interact with some UI, but when I try the same thing manually everything works. What gives?

It's possible that you have a race condition in your test. This issue is quite well described by [this blog post](http://sauceio.com/index.php/2011/04/how-to-lose-races-and-win-at-selenium/) (the post talks about Selenium tests, but the problem and solution translate to Frank).

An easy way to verify whether you are seeing a race condition is to **temporarily** add a short pause in your test just before the interaction which is failing. This would give the app code time to 'win' the race condition. If that solves the issue then you do indeed have a race condition. If it doesn't solve the issue then probably something else is going on.

You should **not leave any sleep(...) calls in your tests** after doing this experiment. The right way to solve race conditions is to use spin asserts, as described in the blog post referenced above. Let's see what that means with a concrete example. Imagine you have the following step but it is sometimes failing to tap a button:

{% highlight ruby %}
    When(/^I tap on the login button$/) do
      touch "button marked:'login'"
    end
{% endhighlight %}

you can first verify that this isn't working due to a race condition by changing the step definition to:
{% highlight ruby %}
    When(/^I tap on the login button$/) do
      sleep 5
      touch "button marked:'login'"
    end
{% endhighlight %}

if that does solve the issue then you should then replace the hardcoded sleep with a spin assert:
{% highlight ruby %}
    When(/^I tap on the login button$/) do
      selector = "button marked:'login'"
      wait_until_element_exists( selector )
      touch( selector )
    end
{% endhighlight %}

Now your test will wait until the button is ready to be tapped (and not any longer), and then tap it.


## How should I set up this APP_BUNDLE_PATH thing that Frank is complaining to me about?

If you're using `frank setup` and `frank build` then you shouldn't have to worry about APP_BUNDLE_PATH at all - the default value should be set correctly.
If you're setting up your Frankified build by hand then you do need to set up your APP_BUNDLE_PATH as part of that.

You need to set APP_BUNDLE_PATH to point to the location of your Frankified app bundle (the directory that ends in .app).
One easy approach is to generate a file containing the APP_BUNDLE_PATH as part of your Frankified xcode build. 
Specifically, you can add a 'run script' build step to your Xcode target's build setup which contains:

`echo APP_BUNDLE_PATH=\"$BUILT_PRODUCTS_DIR/$EXECUTABLE_NAME.app\" > $SRCROOT/Frank/features/support/bundle_path.rb`

That generates a support/bundle_path.rb file ever time you build which sets APP_BUNDLE_PATH to the location of the app bundle which XCode just built. 
Cucumber will by default automagically import anything in that support dir, so it will load that file and make the valid_APP_BUNDLE_PATH value for Frank to use.
