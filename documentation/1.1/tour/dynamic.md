---
layout: tour11
title: Dynamic typing
tab: documentation
unique_id: docspage
author: Gavin King
doc_root: ../..
---

# #{page.title}

Interoperation with a dynamic language like JavaScript poses a 
special challenge for Ceylon. Since no typing information for 
dynamically typed values is available at compile time, the 
compiler can't validate the usual typing rules of the language. 
Therefore, Ceylon lets us write dynamically typed code where 
typechecking is performed at _runtime_.

## Partially typed declarations

The keyword `dynamic` may be used to declare a function or 
value with missing type information. Such a declaration is 
called _partially typed_.

<!-- try: -->
    dynamic xmlHttpRequest = ... ;

<br/>

<!-- try: -->
    void handle(dynamic event) { ... }

<br/>

<!-- try: -->
    dynamic findDomNode(String id) { ... }

Note that `dynamic` is not itself a type. Rather, it represents 
the _absence_ of typing information. Therefore any value is 
considered assignable to a `dynamic` value or returnable by a 
`dynamic` function.

## Dynamically typed expressions

A _dynamically typed expression_ is an expression that involves 
references to program elements for which no typing information 
is available. That includes references to values and functions
declared `dynamic`, along with things defined in a dynamic 
language like JavaScript.

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
outside of a `dynamic` block. The following is not accepted by 
the compiler:

<!-- try: -->
    void handle(dynamic event) {
        print(event.info); //compile error: event has unknown type
    }

When a dynamically typed expression is evaluated, certain 
runtime type checks are performed, which can result in a 
runtime typing exception.


## Interoperating with native JavaScript

The reason Ceylon supports partially typed declarations and
dynamically typed expressions is to allow interoperation with
JavaScript objects written in JavaScript. The next example 
illustrates the use of a native JavaScript API. Try it:

    dynamic { 
        dynamic req = XMLHttpRequest();
        req.open("HEAD", "http://try.ceylon-lang.org/", true);
        req.onreadystatechange = void () {
            if (req.readyState==4) {
                print(req.getAllResponseHeaders());
            }
        };
        req.send();
    }

## Dynamic interfaces

But writing dynamically-typed code is a frustrating, tedious, 
error-prone activity involving lots of debugging and lots of 
finger-typing, since the IDE can't autocomplete the names of 
members of a dynamic type, nor even show us the documentation 
of an object or member when we hover over it.

Therefore, Ceylon makes it possible to write a special sort of 
interface that captures the typing information that is missing 
from a JavaScript API. For example:

<!-- try: -->
    dynamic IXMLHttpRequest {
        shared formal void open(String method, String url, Boolean async);
        shared formal variable Anything()? onreadystatechange;
        shared formal void send();
        shared formal Integer readyState;
        shared formal String? getAllResponseHeaders();
        //TODO: more operations
    }

    IXMLHttpRequest newXMLHttpRequest() {
        dynamic { return XMLHttpRequest(); }
    }

Now we can rewrite the example above, without the use of `dynamic`:

<!-- try-pre:
    dynamic IXMLHttpRequest {
        shared formal void open(String method, String url, Boolean async);
        shared formal variable Anything()? onreadystatechange;
        shared formal void send();
        shared formal Integer readyState;
        shared formal String? getAllResponseHeaders();
        //TODO: more operations
    }

    IXMLHttpRequest newXMLHttpRequest() {
        dynamic { return XMLHttpRequest(); }
    }
    
-->
    IXMLHttpRequest req = newXMLHttpRequest();
    req.open("HEAD", "http://try.ceylon-lang.org/", true);
    req.onreadystatechange = void () {
        if (req.readyState==4) {
            print(req.getAllResponseHeaders());
        }
    };
    req.send();

Thus, it's possible to create Ceylon libraries that provide a 
typesafe view of native JavaScript APIs.

### Gotcha!

Note that a `dynamic` interface is a convenient fiction! The
Ceylon compiler can't do anything to ensure that the native
JavaScript object you assign to the `dynamic` interface type
_actually implements the operations_ that the interface
declares!

So, if you're not careful, you can _still_ get runtime type
exceptions!

## Dynamic instantiation expressions

Occasionally it's necessary to instantiate a JavaScript `Array` 
or plain JavaScript `Object` (which is not the same thing as a 
Ceylon `Object`!). We may use a special-purpose _dynamic 
enumeration expression_:

    dynamic {
        dynamic obj = dynamic [ hello="Hello, World"; count=11; ];
        print(obj.hello);
        print(obj.count);
        
        dynamic arr = dynamic [ 12, 13, 14 ];
        print(arr[0]);
        print(arr[2]);
    }

Note that these expressions are _not_ considered to produce an 
instance of a Ceylon class.


## There's more ...

Well, no, actually, we've finished the tour! Of course, there's 
still plenty of scope for you to explore Ceylon on your own. 
You should now know enough to start writing Ceylon code for 
yourself, and start getting to know the platform modules.

Alternatively, if you want to keep reading you can browse the 
[reference documentation](#{page.doc_root}/reference) or (if you're sitting 
comfortably) read the [specification](#{site.urls.spec_current}).
