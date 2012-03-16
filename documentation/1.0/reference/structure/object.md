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
implictly [instantiated](../../expression/instantiation) 
exactly once at the place it is defined, and nowhere else.

## Usage 

A trivial `object` declaration looks like this:

    object o {
        /* declarations of object members */
    }

## Description

### Notation

This reference uses `object` (in a monospaced font) when discussing an `object`
declaration, which is the subject of this page. A class instance may be 
referred to as an object (in the usual font).

### Constraints

### Parent declaraions

`object` declarations are not permitted as members of 
[interfaces](../interface).

### Members

The permitted members of `object`s are [classes](../class), 
[interfaces](../interface), 
[methods](../method), 
[attributes](../attribute)
and [`object`s](../object).

## See also

* Top level types are contained in [compilation units](../compilation-unit)
* [`class` declaration](../../type/class)
* [`interface` declaration](../../type/interface)
* [`object` declaration](../../type/object)
