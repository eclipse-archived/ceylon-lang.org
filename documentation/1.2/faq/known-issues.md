---
title: Known issues in 1.1
layout: known-issues11
toc: true
tab: documentation
unique_id: docspage
author: Stephane Epardaud
---
# #{page.title}

[No matter how many tests we have](/blog/2012/02/02/how-we-test-ceylon/), 
we always find some bugs after each release. To make it easier for you to 
figure out if you hit a known bug, and how best to work around it, we've 
made a list. Check it out, and if you can't find your bug, don't hesitate 
to [report it](/code/issues/). 

## Command-line tools (<code>ceylon</code>)

No known issue.

## JVM Compiler (<code>ceylon compile</code>)

<div class="known-issue">
<a class="see" href="https://github.com/ceylon/ceylon-compiler/issues/470">See issue</a>
<div class="title"><code>ceylon compile</code> fails to compile module if Java code 
depends on Ceylon code in a single module</div>
<b>Workaround:</b>
<div class="workaround">Put the Java classes in a separate module and compile them
after the Ceylon code.</div>
</div>

## JavaScript Compiler (<code>ceylon compile-js</code>)

No known issue.

## Documentation generator (<code>ceylon doc</code>)

No known issue.

## SDK (<code>ceylon.language</code> and other platform modules)

No known issue.

