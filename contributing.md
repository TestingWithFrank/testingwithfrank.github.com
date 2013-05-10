---
layout: default
title: Contributing
---

We are always happy to accept help! We can use help with
documentation, bug fixes and new features. 

Fork the [Github Repository](http://github.com/moredip/Frank), make your
changes and send a pull request.

Feedback, suggestions and questions are always welcome on the [Mailing
List](mailing_lists.html).

We also track issues and feature requests [here](http://github.com/moredip/Frank/issues).

## Building the Frank obj-c libraries locally
Simply run `rake` from the root of the project directory. This will create a clean build of the static libraries, leaving them in the `dist` dir. To test those out locally you can manually copy them into your app's `Frank` directory (overwriting the existing libraries), and then rebuild the Frankified version of your app with `frank build`.

## Testing local changes to the ruby gem
You can use the `RUBYLIB` environment variable to get your Ruby environment to use your in-development version of the Frank gem rather than the installed gem
version. 

Let's say You have a local copy of the Frank repo in `~/git/Frank` and you've made some changes to a helper module that you'd like to test. You can do that by pointing RUBYLIB to your local copy of the gem code and then running cucumber as you usually would:

    > cd ~/git/MyiOSApp
     > export RUBYLIB=~/git/Frank/gem/lib
     > cucumber Frank/features
