---
layout: tour
title: Dynamic typing
tab: documentation
unique_id: docspage
author: Gavin King
doc_root: ../..
---

# #{page.title}

Interoperation with a dynamic language like JavaScript poses a special
challenge for Ceylon. Since no typing information for dynamically typed 
values is available at compile time, the compiler can't validate the
usual typing rules of the language. Therefore, Ceylon lets us write
dynamically typed code where typechecking is performed at _runtime_.

## Partially typed declarations

The keyword `dynamic` may be used to declare a function or value with
missing type information. Such a declaration is called _partially typed_.

<!-- try: -->
    dynamic xmlHttpRequest = ... ;

<br/>

<!-- try: -->
    void handle(dynamic event) { ... }

<br/>

<!-- try: -->
    dynamic findDomNode(String id) { ... }

Note that `dynamic` is not itself a type. Rather, it represents the
_absence_ of typing information. Therefore any value is considered
assignable to a `dynamic` value or returnable by a `dynamic` function.

## Dynamically typed expressions

A _dynamically typed expression_ is an expression that involves 
references to program elements for which no typing information is
available. That includes references to values and functions
declared `dynamic`, along with things defined in a dynamic language
like JavaScript.

A dynamically typed expression may only occur within a `dynamic`
block. The `dynamic` block serves to suppress certain type checks
that the compiler normally performs.

<!-- try: -->
    dynamic xmlHttpRequest;
    dynamic {
        xmlHttpRequest = XMLHttpRequest();
    }

<br/>

<!-- try: -->
    void handle(dynamic event) {
        dynamic {
            print(event.info);
        }
    }

Note: you _cannot_ make use of a partially typed declaration
outside of a `dynamic` block.

## Runtime type checking

When a dynamically typed expression is evaluated, certain
runtime type checks are performed, which can result in a 
typing exception.

## Example

This example demonstrates the use of a native JavaScript API. Try it:

    dynamic { 
        dynamic req = XMLHttpRequest();
        req.open("HEAD", "http://try.ceylon-lang.org/", true);
        req.onreadystatechange = void () {
            if (req.readyState==4) {
                alert(req.getAllResponseHeaders());
            }
        };
        req.send();
    }

## There's more ...

Well actually, we've finished the tour! Of course, there's still plenty of 
scope for you to explore Ceylon on your own. You should now know enough to 
start writing Ceylon code for yourself, and start getting to know the 
platform modules.

Alternatively, if you want to keep reading you can browse the 
[reference documentation](#{page.doc_root}/reference) or (if you're sitting 
comfortably) read the [specification](#{site.urls.spec_current}).
