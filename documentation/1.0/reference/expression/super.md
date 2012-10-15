---
layout: reference
title: '`super`'
tab: documentation
unique_id: docspage
author: Tom Bentley
milestone: Milestone 1
doc_root: ../..
---

# #{page.title}

`super` allows a class to access superclass members.


## Usage 

Here's a simple example:
  
    class Super() {
        shared default void m() {
        }
    }
    class Sub() extends Super() {
        shared actual void m() {
            super.m();
            // now do something particular to Sub
        }
    }


## Description

`super` refers to the current instance, but its members are those of the 
superclass of the current class. 

It is necessary when a method in a subclass invokes the refined method in 
a superclass. 


## See also

