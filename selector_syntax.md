---
layout: default
title: View Selectors
---

<style>
img {
  max-width: 600px;
}
</style>

## Introduction
When interacting with the views your app is made up of you need a way to specify a set of views. By default Frank uses a selector engine called Shelley. We'll describe the selector syntax that shelley supports. 

We'll use an open-source app called Cheddar to demonstrate how to write these view selectors. Included are screenshots from Symbiote - we highly recommend that you experiement with view selectors using Symbiote.

## Basic syntax
a view selector consists of a sequence of selection fragments, seperated by spaces. Strings can be wrapped in single or double quotes

## Selecting a view based on its accessibility label
`view marked:'Milk'`

<img src="/images/view_selectors/example6.png"/>

## Selecting a view based on its class
`view:'UITableViewCell'` selects all views of class UITableViewCell.


You can also use a shorthand for commonly used classes:
`tableViewCell` is the same as writing `view:'UITableViewCell'` 

<img src="/images/view_selectors/example2.png"/>

## Selecting subviews
`tableViewCell label` selects all UILabels within UITableViewCells

<img src="/images/view_selectors/example3.png"/>

## Selecting subviews based on class and accessibility label
`tableViewCell label marked:'Milk'` selects all UILabels with an accessibility label of 'Milk' within a UITableViewCell

<img src="/images/view_selectors/example4.png"/>

## Pivoting to select a parent of a view
`tableViewCell label marked:'Milk' parent tableViewCell`

<img src="/images/view_selectors/example11.png"/>

## selecting cousins of a view
`tableViewCell label marked:'Milk' parent tableViewCell view:'UIImageView' marked:'small-check'`

<img src="/images/view_selectors/example12.png"/>



