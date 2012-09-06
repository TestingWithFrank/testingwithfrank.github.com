---
layout: default
title: Igor Query Syntax
---

## Introduction
A key part of automating a UI is identifying the UI elements to interact with.
Once you've identified elements you can simulate actions against then (e.g. tapping or swiping)
or you can inspect their state (e.g. checking the value of a label or whether button is enabled).

In web application automation you would usually use CSS or XPath selectors to select parts of your UI.
With Frank you have a similar choice of selector engines.
The default selector engine is [Shelley](selector_syntax.html),
which implements a syntax inherited from UISpec.

A popular alternative syntax is the [Igor Query Language](https://github.com/dhemery/igor/wiki/Igor-Query-Language),
which was patterned after the W3C's CSS selector syntax.

We'll introduce Igor by showing examples of selectors and what they select.
We'll select views from an open-source application called
[Cheddar](https://github.com/nothingmagical/cheddar-ios).

To learn more about Igor, see the installation instructions, syntax description, and usage tips on the [Igor wiki](https://github.com/dhemery/igor/wiki).
The source code is available on the [Igor github project](https://github.com/dhemery/igor).

This article uses screenshots taken from Symbiote to show what views are selected by each example selector.
The best way to learn how selectors work is to experiment with them interactively using Symbiote.
If you enter a view selector and choose a selector engine,
Symbiote can highlight the views it would select,
or flash the views in the simulator.

## Basic syntax
An Igor query consists of a sequence of *instance patterns,*
separated by special operators called *combinators.*
An instance pattern matches views based on the characteristics of the individual views.
Combinators match views based on their relationships to each other
(e.g. ancestor/descendant, parent/child, or sibling).

All of the following are valid Igor queries:

* `UIView`
* `UITextField*[accessibilityLabel=='Foo']`
* `UITableViewCell > [accessibilityLabel=='Foo Bar Baz']`
* `CustomViewClass UITableViewCell [accessibilityLabel='blah']`

## Examples

### Nothing selected
First of all, for reference here's a view of our example UI without anything selected

<img src="/images/view_selectors/example5.png"/>

### Selecting a view based on its accessibility label
`[accessibilityLabel=='Milk']`

<img src="/images/view_selectors/example6.png"/>

### Selecting a view based on its class
`UITableViewCell` selects all views of class UITableViewCell.

<img src="/images/view_selectors/example2.png"/>

### Selecting subviews
`UITableViewCell UILabel` selects all UILabels within UITableViewCells.
The space between UITableViewCell and UILabel
is a special operator called a "descendant combinator."
It tells Igor "now look for descendants."
Spaces in Igor work the same way as in CSS selectors.

<img src="/images/view_selectors/example3.png"/>

### Selecting subviews based on class and accessibility label
`UITableViewCell UILabel[accessibilityLabel=='Milk']` selects all UILabels with an accessibility label of 'Milk' within a UITableViewCell.

<img src="/images/view_selectors/example4.png"/>

### Selecting the a parent of a view
`$UITableViewCell UILabel[accessibilityLabel=='Milk']`

The $ is a special operator in Igor,
called the *subject marker.*
Normally (if there is no $ in the query)
Igor selects the views that match the last instance pattern in the query.
The subject marker
tells Igor to select the views that match some other instance pattern,
typically a parent or ancestor of the last pattern.

So this query tells Igor to select the UITableViewCells that contain UILabels with accessibility label of 'Milk'.

<img src="/images/view_selectors/example11.png"/>

### selecting cousins of a view
`(UITableViewCell UILabel[accessibilityLabel=='Milk']) UIImageView[accessibilityLabel=='small-check']`

Parentheses tell Igor to:

 1. Find subtrees that match what's in the parentheses.
 1. Select the roots of the subtrees.
 1. Continue the rest of the query starting from the roots of the subtrees.

In this example,
Igor first finds find all of the subtrees
where a UITableViewCell contains a UILabel with accessibility label of 'Milk'.

Next, Igor selects the roots of the subtrees: the UITableViewCells that contain the UILabels.

Finally, Igor finds the UIImageViews with accessibility label 'small-check' inside those subtrees.

This can be very useful when you need to select one view based on the label of a nearby view.
In this example you might
want to check the box for the 'Milk' row.

<img src="/images/view_selectors/example12.png"/>

