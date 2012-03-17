---
layout: reference
title: Class Instantiation
tab: documentation
unique_id: docspage
author: Tom Bentley
milestone: Milestone 1
doc_root: ../..
---

# #{page.title}

Class instantiation creates a new instance of a [class](../../structure/class).


## Usage 

Like [method invocation](../invocation) class instantiation can use 
positional argument lists:

<!-- cat: class MyClass(Integer num, String name) {} void m() {-->
    MyClass(1, "");
<!-- cat: } -->

Or named argument lists:

<!-- cat: class MyClass(Integer num, String name) {} void m() {-->
    MyClass{
        name="";
        num=2;
    };
<!-- cat: } -->

## Description

### Syntax

Synatically, class instantiation looks the same as 
[method invocation](../invocation).


## See also

