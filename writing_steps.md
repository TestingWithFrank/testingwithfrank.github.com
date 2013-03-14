---
layout: default
title: Writing your own steps
---

Defining your own step definitions is pretty straightforward. A good place to start is to look at [the 
step definitions that come with Frank](http://github.com/moredip/Frank/blob/master/gem/lib/frank-cucumber/core_frank_steps.rb) 
to get an idea of what a step definiton looks like.

The first thing to do when writing your own steps is to write a feature file which contains the step you want
to create, and then run that feature in cucumber. Cucumber will complain that that step doesn't exist, but in doing so it 
will also output the boilerplate step definition code you need to get started defining that step yourself. Copy and paste
that boilerplate into a new .rb file inside `features/step_definitions/`. 

Now all you need to do is fill out that step definition block with the frank-cucumber commands you need to make that step a reality.
Most of your step definition code is going to consist of calls to frank helper methods. This helper methods will do the heavy lifting
for you of requesting certain automation actions to be carried out on your app or of checking that the state of your app meets your expectations.
The helper methods are documented [here](http://rdoc.info/gems/frank-cucumber/Frank/Cucumber/FrankHelper).

For more guidance on this topic, take a look at [this article](http://blog.thepete.net/blog/2012/06/24/writing-your-first-frank-test/). The second half of that article give some more detailed examples of how to write your own step definitions.
