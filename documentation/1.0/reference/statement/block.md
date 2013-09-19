---
layout: reference
title: 'Statement blocks'
tab: documentation
unique_id: docspage
author: Tom Bentley
---

# #{page.title}

A block is not a statement itself, but a list of statements enclosed in braces `{` and `}`.

## Usage 

A block is simply a series of statements enclosed, in braces `{` and `}`.

## Description

Blocks represent a series of statements which should be executed sequentially.

Class, integer method and getter definitions are all defined using blocks of 
statements. The the control structures `if`, `for`, `switch`, `try` and `while`
blocks are the sequences of statements which are being controlled (executed or not).

Unlike Java, Ceylon does not support local blocks that are not associated 
with a control structure:

<!-- lang:java -->
    int javaExample() {
        {
            int x = 1;
        }
        {
            // a different x
            int x = 0;
        }
    }

## See also

* [Blocks](#{site.urls.spec_current}#blocksandstatements) in the spec
