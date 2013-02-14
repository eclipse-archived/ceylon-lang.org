---
layout: reference
title: object
tab: documentation
unique_id: docspage
author: Tom Bentley
milestone: Milestone 1
---

# #{page.title}

An `object` declaration is an anonymous [class](../class) that is 
implicitly [instantiated](../../expression/class-instantiation)
exactly once at the place it is defined, and nowhere else.

## Usage 

A trivial `object` declaration looks like this:

    object o {
        /* declarations of object members */
    }

## Description

### Type parameters and parameters

An `object` declaration does not specify parameters or type parameters.

### Notation

This reference uses `object` (in a monospaced font) when discussing an `object`
declaration, which is the subject of this page. A class instance may be 
referred to as an object (in the usual font).

### Constraints

### Parent declaraions

`object` declarations are not permitted as members of 
[interfaces](../interface).

### Shared `object`s

Because an `object` declaration is simultaneously defining and instantiating an 
anonymous class it can have the same annotations as an 
[attribute](../attribute).

### Members

The permitted members of `object`s are [classes](../class), 
[interfaces](../interface), 
[methods](../method), 
[attributes](../attribute)
and [`object`s](../object).

## See also


