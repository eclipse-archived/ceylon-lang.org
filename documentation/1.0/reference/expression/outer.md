---
layout: reference
title: '`outer`'
tab: documentation
unique_id: docspage
author: Tom Bentley
milestone: Milestone 3
doc_root: ../..
---

# #{page.title}

`outer` allows a local class to refer to members of the containing class or 
interface.


## Usage 

A simple example:

    class Outer() {
        void m() {
        }
        class Inner() {
            outer.m();
        }
    }


## Description

`outer` refers to the current instance of the class or interface that 
contains current instance.


## See also

