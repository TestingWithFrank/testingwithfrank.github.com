---
layout: default
title: View Selectors
---

<style>
img {
  width: 600px;
}
</style>

## Introduction
When interacting with the views your app is made up of you need a way to specify a set of views. By default Frank uses a selector engine called Shelley. We'll describe the selector syntax that shelley supports. 

We'll use an open-source app called Cheddar to demonstrate how to write these view selectors. Included are screenshots from Symbiote - we highly recommend that you experiement with view selectors using Symbiote.

## Basic syntax
a view selector consists of a sequence of selection fragments, seperated by spaces. Strings can be wrapped in single or double quotes

## Selecting a view based on its accessibility label
`view marked:'Milk'`
<img src="/images/view_selectors/Screen Shot 2012-08-11 at 11.53.21 AM.png"/>

## Selecting a view based on its class
`view:'UITableViewCell'` selects all views of class UITableViewCell
<img src="/images/view_selectors/Screen Shot 2012-08-11 at 12.51.16 PM.png"/>

You can also use a shorthand for commonly used classes:
`tableViewCell` also selects all views of class UITableViewCell
<img src="/images/view_selectors/Screen Shot 2012-08-11 at 11.51.21 AM.png"/>

## Selecting subviews
`tableViewCell label` selects all UILabels within UITableViewCells
<img src="/images/view_selectors/Screen Shot 2012-08-11 at 11.51.48 AM.png"/>

## Selecting subviews based on class and accessibility label
`tableViewCell label marked:'Milk'` selects all UILabels with an accessibility label of 'Milk' within a UITableViewCell
<img src="/images/view_selectors/Screen Shot 2012-08-11 at 11.52.22 AM.png"/>

## Pivoting to select a parent of a view
`tableViewCell label marked:'Milk' parent tableViewCell`
<img src="/images/view_selectors/Screen Shot 2012-08-11 at 12.08.39 PM.png"/>

## selecting cousins of a view
`tableViewCell label marked:'Milk' parent tableViewCell view:'UIImageView' marked:'small-check'`
<img src="/images/view_selectors/Screen Shot 2012-08-11 at 12.09.07 PM.png"/>





<img src="/images/view_selectors/.png"/>
