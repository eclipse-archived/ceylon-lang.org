---
layout: reference13
title_md: '`dynamic` Interface Declarations'
tab: documentation
unique_id: docspage
author: Tom Bentley
---

# #{page.title_md}

A `dynamic` interface is a declaration of a type for an object defined in a 
dynamically typed language. It allows interoperation between Ceylon
and objects that were created outside Ceylon's type system (and which 
therefore lack any Ceylon type information).

## Usage 

Consider a browser's `window` object, we might declare a `Window` 
type for it like this:

    dynamic Window {
        shared formal Document document;
        shared formal Location location;
        shared formal History history;
        shared formal void focus();
        shared formal void blur();
        shared formal void alert(String message = "");
        // ...
    }


## Description

All the members of a `dynamic` interface must be `formal` and any satisfied
interfaces must also be a `dynamic` interface.

Assignment of an untyped value to a value with a `dynamic` interface type 
is only allowed within a [`dynamic` block](../../statement/dynamic-block):

    Window window;
    dynamic {
        // eval is javascripts eval, which has no Ceylon type information
        // and can only be used within a dynamic block
        window = eval("window");
    }


## See also

* [`dynamic` interfaces](#{site.urls.spec_current}#dynamicinterfaces) in the 
  Ceylon language specification
* [`dynamic` blocks](../../statement/dynamic-block)
* [`ceylon.interop.browser`](#{site.urls.apidoc_current_interop_browser}) provides dynamic interfaces for common 
browser APIs.

