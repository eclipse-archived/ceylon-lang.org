---
layout: reference
title: '`::` supertype access'
tab: documentation
unique_id: docspage
author: Tom Bentley
milestone: Milestone 1
doc_root: ../..
---

# #{page.title}

`::` allows a class or interface to access the members of its supertypes.


## Usage 

Here's a simple example:
  
    interface Super {
        shared default void m() {
        }
    }
    class Sub() satisfies Super {
        shared actual void m() {
            Super::m();
            // now do something particular to Sub
        }
    }


## Description

The supertype accessor `::` is used to access a member of a superclass or 
superinterface. It can be consider a more general version of `super`, which 
only allows you to access a superclass. 

Then `::` is used to access a supertype's member the instance does not change, 
but only the members declared on that supertype are visible

## See also

* [`super`](../super)
