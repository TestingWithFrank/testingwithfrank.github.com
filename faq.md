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

## Can I use Frank to execute arbitrary code in my app as part of a test?

Yes. Frank exposes an [app_exec](http://rdoc.info/github/moredip/Frank/Frank/Cucumber/FrankHelper#app_exec-instance_method) command which you can use to execute
any method which your app delegate implements.

## Can I automate a physical device using Frank.

Yes, people have this working, but it hasn't been documented very well. Ask on the [mailing list](mailing_lists.html) for more details.


## How can I automate filling out a text field using the keyboard?
Recent releases of Frank have a [type_into_keyboard](http://rdoc.info/github/moredip/Frank/Frank/Cucumber/KeyboardHelper#type_into_keyboard-instance_method) method.
