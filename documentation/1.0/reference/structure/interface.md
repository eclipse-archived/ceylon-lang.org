---
layout: reference
title: Interfaces
tab: documentation
unique_id: docspage
author: Tom Bentley
milestone: Milestone 1
---

# #{page.title}

An interface is a stateless type that cannot be 
[instantiated](../../expression/instantiation) directly.

## Usage 

A trivial interface declaration looks like this:

    interface I {
        /* declarations of interface members */
    }


## Description

### Type parameters

### Constraints

### Members

The permitted members of interaces are [classes](../class), 
[interfaces](../interface), 
[methods](../method), 
and [attributes](../attribute).

Note that an interface cannot have an [`object`](../object) member.

## See also

* Top level types are contained in [compilation units](../compilation-unit)
* [`class` declaration](../../type/class)
* [`interface` declaration](../../type/interface)
* [`object` declaration](../../type/object)
