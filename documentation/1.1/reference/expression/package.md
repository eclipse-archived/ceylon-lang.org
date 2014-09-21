---
layout: reference11
title_md: '`package`'
tab: documentation
unique_id: docspage
author: Tom Bentley
---

# #{page.title_md}

`package` can be used to qualify a reference.

## Usage 

<!-- try: -->
    void example() {}

    class Example() {
        void example() {
            // Calls the top level example, does not recurse.
            package.example();
        }
    }

## Description

`package` itself is not an expression but is permitted to qualify an expression.

### Type

Because `package` itself is not an expression it does not have a type.

If you want to obtain an instance representing a package you can use a 
[declaration reference](../meta-reference): `` `package com.example` ``.

## See also

* [`package`](#{site.urls.spec_current}#super) in the spec

