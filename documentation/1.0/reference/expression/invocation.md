---
layout: reference
title: Method Invocation
tab: documentation
unique_id: docspage
author: Tom Bentley
milestone: Milestone 1
doc_root: ../..
---

# #{page.title}

Method invocation transfers execution to the given method.

## Usage 

A simple example of postional invocation:

<!-- implicit-id:m: void m(Integer i, String s) {} -->

<!-- cat-id:m -->
    m(2, "bonjour"); 

A simple example of named argument invocation:

<!-- cat-id: m -->
    m{
        s = "ola";
        i = 5;
    };


## Description

### Postional Invocation

Syntactically, postional invocation uses parentheses (`(` and `)`) to 
enclose the arguments which are separated with commas (`,`).

Parameters with [default values](../../structure/method#defaulted_parameters) 
may be omitted from the argument list.

For example, given a method `m` [declared](../../structure/method) like this

<!-- id: m -->
    void m(Integer i, String s="hello", Boolean... b) {
        /* method block: statements */
    }
    
then positional invocations look like this:

<!-- cat-id: m -->
<!-- cat: void x() { -->
    m(1);   // default parameter, empty sequence
    m(2, "bonjour");  // empty sequence
    m(3, "guttentag", true); // singleton sequence
    m(4, "guttentag", true, true);
<!-- cat: } -->

TODO Argument with ellipsis to a Sequenced Parameter

### Named argument Invocation

Syntactically, named argument invocation uses braces (`{` and `}`) to 
enclose the arguments which are separed with semicolons (`;`). The last 
named argument must also have a semicolon. Each named argument consists of the 
argument name separated from the expression with the equals (`=`) specifier.

A named argument invocation's final argument may be unnamed if it was 
declared as a [sequenced parameter](../../structure/method#sequenced_parameter)
and in this case the sequence elements are comma separated.

For example given a method `m` [declared](../../structure/method) like this

<!-- id: m -->
    void m(Integer i, String s="hello", Boolean... b) {
        /* method block: statements */
    }
    
then named argument invocations look like this:

<!-- cat-id: m -->
<!-- cat: void x() { -->
    m{
        s = "ola";
        i = 5;
    };
     
    m{
        b = {true, false};
        s = "你好";
        i = 6;    
    };
    
    m{
        s = "Kia ora";
        i = 7;
        true, true, false
    };
<!-- cat: } -->

TODO Argument with ellipsis to a Sequenced Parameter

### Callable invocation

A [callable reference](../method-reference) such as 
`Callable<String, Boolean>` has to be assigned to a function in order to be 
called:

    void m(Callable<String, Boolean> callable) {
        String f (Boolean b) = callable;
        String s = f(true);
    }

## See also


