---
layout: reference
title: '`this`'
tab: documentation
unique_id: docspage
author: Tom Bentley
milestone: Milestone 1
doc_root: ../..
---

# #{page.title}

`this` refers to the current instance..


## Usage 

Here's a simple example:

    class C(String initial) {
        variable String attr = initial;
        void m(String attr) {
            this.attr = attr;
        }
    }


## Description

`this` is useful for avoiding ambiguity between a variable in scope and 
a member of the current member


## See also

