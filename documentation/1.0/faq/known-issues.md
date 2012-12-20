---
title: Known issues in M3
layout: known-issues
toc: true
tab: documentation
unique_id: docspage
author: Stephane Epardaud
---

[However many tests we have](/blog/2012/02/02/how-we-test-ceylon/) in Ceylon, we managed to find 
several bugs after we [released M4](/blog/2012/10/29/ceylon-m4-analytical-engine/).
We're not happy about this, but hey, that's the way it is, so while we're busy squashing them
in our code repository, the fact is you will need to use workarounds for them until we build
a new release.

In order to make it easier for you to figure out if you hit a known M4 bug, and how best to
work around it, we've made a list. Check it out, and if you can't find your bug, don't hesitate
to [report it](/code/issues/). 

## Command-line tools (<code>ceylon</code>)

<div class="known-issue">
<a class="see" href="https://github.com/ceylon/ceylon-compiler/issues/875">See issue</a>
<div class="title"><code>ceylon</code> command line does not respect <code>JAVA_HOME</code> on Windows.</div>
<b>Workaround:</b>
<div class="workaround">
 Either configure Java properly so that the registry points to your JDK 7 installation (the default
 when using the installer), or replace the <code>bin\java.bat</code> of your unpacked Ceylon distribution with 
 <a href="https://github.com/ceylon/ceylon-compiler/raw/master/bin/java.bat">https://github.com/ceylon/ceylon-compiler/raw/master/bin/java.bat</a>
</div>
</div>

## JVM Compiler (<code>ceylon compile</code>)

<div class="known-issue">
<a class="see" href="https://github.com/ceylon/ceylon-compiler/issues/470">See issue</a>
<div class="title"><code>ceylon compile</code> fails to compile module if Java classes and Ceylon classes depend on one another</div>
<b>Workaround:</b>
<div class="workaround">None</div>
</div>

<div class="known-issue">
<a class="see" href="https://github.com/ceylon/ceylon-compiler/issues/872">See issue</a>
<div class="title">Class fails to compile if it implements the same interface twice in its hierarchy, and interface contains
non-<code>formal</code> and non-<code>default</code> methods.</div>
<b>Workaround:</b>
<div class="workaround">Make these interface methods <code>default</code></div>
</div>

<div class="known-issue">
<a class="see" href="https://github.com/ceylon/ceylon-compiler/issues/868">See issue</a>
<div class="title">Toplevel methods and classes cannot be run (from the IDE or command-line) if they contain optional
parameters.</div>
<b>Workaround:</b>
<div class="workaround">Invoke a toplevel method that takes no optional parameter which invokes your toplevel method or class that
has optional parameters.</div>
</div>

<div class="known-issue">
<a class="see" href="https://github.com/ceylon/ceylon-compiler/issues/932">See issue</a>
<div class="title">Interoperability with overloaded <code>toString</code>/<code>hashCode</code> methods.</div>
<b>Workaround:</b>
<div class="workaround">Write a Java class in your Ceylon module, with a static method that
invokes the overloaded <code>toString</code> or <code>hashCode</code> method on your behalf.</div>
</div>

## JavaScript Compiler (<code>ceylon compile-js</code>)

No known issue.

## Documentation generator (<code>ceylon doc</code>)

No known issue.

## SDK (<code>ceylon.language</code> and other platform modules)

No known issue.

