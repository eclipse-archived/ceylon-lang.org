---
title: Known issues in M2 
layout: known-issues
toc: true
tab: documentation
unique_id: docspage
author: Stephane Epardaud
---

[However many tests we have](/blog/2012/02/02/how-we-test-ceylon/) in Ceylon, we managed to find 
several bugs after we [released M2](/blog/2012/03/20/ceylon-m2-minitel/).
We're not happy about this, but hey, that's the way it is, so while we're busy squashing them
in our code repository, the fact is you will need to use workarounds for them until we build
a new release.

In order to make it easier for you to figure out if you hit a known M2 bug, and how best to
work around it, we've made a list. Check it out, and if you can't find your bug, don't hesitate
to [report it](/code/issues/). 

## Compiler (<code>ceylonc</code>)

<div class="known-issue">
<a class="see" href="https://github.com/ceylon/ceylon-compiler/issues/463">See issue</a>
<div class="title">Source archives are corrupted</div>
<b>Workaround:</b>
<div class="workaround">Zip them manually or via Ant</div>
</div>

<div class="known-issue">
<a class="see" href="https://github.com/ceylon/ceylon-compiler/issues/493">See issue</a>
<div class="title">Module license is not defaulted</div>
<b>Workaround:</b>
<div class="workaround">Set a license</div>
</div>

<div class="known-issue">
<a class="see" href="https://github.com/ceylon/ceylon-compiler/issues/492">See issue</a>
<div class="title">Escaped character literals are broken</div>
<b>Workaround:</b>
<div class="workaround">Use their ASCII equivalent: <code>12.character</code></div>
</div>

<div class="known-issue">
<a class="see" href="https://github.com/ceylon/ceylon-compiler/issues/491">See issue</a>
<div class="title"><code>"\\b"</code> string literals should end up be translated into <code>\b</code> don't</div>
<b>Workaround:</b>
<div class="workaround">Use string concatenation <code>"\\" + "b"</code></div>
</div>

<div class="known-issue">
<a class="see" href="https://github.com/ceylon/ceylon-compiler/issues/490">See issue</a>
<div class="title">Character used in string format prints its code point instead of its value</div>
<b>Workaround:</b>
<div class="workaround">Use <code>"foo " c.string ""</code></div>
</div>

<div class="known-issue">
<a class="see" href="https://github.com/ceylon/ceylon-compiler/issues/488">See issue</a>
<div class="title">Type params of type Java String vs Ceylon Strings</div>
<b>Workaround:</b>
<div class="workaround">Use the Java String type explicitely and get a Ceylon string by using its <code>string</code> attribute</div>
</div>

<div class="known-issue">
<a class="see" href="https://github.com/ceylon/ceylon.language/issues/70">See issue</a>
<div class="title">Java methods/fields that return null Strings can be wrapped to Ceylon Strings that contain null, thereby hiding the null</div>
<b>Workaround:</b>
<div class="workaround">None</div>
</div>

<div class="known-issue">
<a class="see" href="https://github.com/ceylon/ceylon-spec/issues/253">See issue</a>
<div class="title">Cannot implement interfaces that have non-<code>shared</code> concrete interface methods</div>
<b>Workaround:</b>
<div class="workaround">Ignore the error, it is a bogus IDE error</div>
</div>

<div class="known-issue">
<a class="see" href="https://github.com/ceylon/ceylon-compiler/issues/460">See issue</a>
<div class="title">Modules with common part: happens when you have <code>com.foo</code> and <code>com.foobar</code> modules.</div>
<b>Workaround:</b>
<div class="workaround">Rename your modules so one is not a prefix of the other</div>
</div>

<div class="known-issue">
<a class="see" href="https://github.com/ceylon/ceylon-compiler/issues/459">See issue</a>
<div class="title">Can't import <code>ceylon.language</code>.</div>
<b>Workaround:</b>
<div class="workaround">List <code>ceylon.language</code> as a module dependency.</div>
</div>

<div class="known-issue">
<a class="see" href="https://github.com/ceylon/ceylon-compiler/issues/464">See issue</a>
<div class="title">Can't extend class with optional parameters. For example extending <code>Exception</code>.</div>
<b>Workaround:</b>
<div class="workaround">Pass every required parameter to the constructor</div>
</div>

<div class="known-issue">
<a class="see" href="https://github.com/ceylon/ceylon-compiler/issues/458">See issue</a>
<div class="title">Can't import toplevel object from other module</div>
<b>Workaround:</b>
<div class="workaround">Use a wildcard import</div>
</div>

<div class="known-issue">
<a class="see" href="https://github.com/ceylon/ceylon-compiler/issues/468">See issue</a>
<div class="title"><code>ceylonc</code> to upload module to remote repo if it contains Java classes</div>
<b>Workaround:</b>
<div class="workaround">Compile locally then upload manually</div>
</div>

<div class="known-issue">
<a class="see" href="https://github.com/ceylon/ceylon-compiler/issues/469">See issue</a>
<div class="title"><code>ceylonc</code> fails to compile module if it contains Java classes</div>
<b>Workaround:</b>
<div class="workaround">Compile first the Java classes, then the Ceylon code</div>
</div>

<div class="known-issue">
<a class="see" href="https://github.com/ceylon/ceylon-compiler/issues/470">See issue</a>
<div class="title"><code>ceylonc</code> fails to compile module if Java classes and Ceylon classes depend on one another</div>
<b>Workaround:</b>
<div class="workaround">None</div>
</div>

## Documentation generator (<code>ceylond</code>)

<div class="known-issue">
<a class="see" href="https://github.com/ceylon/ceylon-compiler/issues/466">See issue</a>
<div class="title"><code>ceylond</code> type checks more than the module I'm telling it to</div>
<b>Workaround:</b>
<div class="workaround">Use a single module in your source path</div>
</div>

<div class="known-issue">
<a class="see" href="https://github.com/ceylon/ceylon-compiler/issues/467">See issue</a>
<div class="title"><code>ceylond</code> fails when module contains Java classes.</div>
<b>Workaround:</b>
<div class="workaround">Comment out all the code that uses the Java classes before generating the
documentation. Do not forget to uncomment it when compiling it!</div>
</div>

<div class="known-issue">
<a class="see" href="https://github.com/ceylon/ceylon-compiler/issues/495">See issue</a>
<div class="title"><code>ceylond</code> does not work when there are dependent modules</div>
<b>Workaround:</b>
<div class="workaround">None</div>
</div>

## SDK (<code>ceylon.language</code>)

<div class="known-issue">
<a class="see" href="https://github.com/ceylon/ceylon.language/issues/63">See issue</a>
<div class="title"><code>String.span</code> and <code>String.segment</code> don't work. Similarly <code>str[x..y]</code> and <code>str[x...]</code>. Those produce buggy results and sometimes throw exceptions.</div>
<b>Workaround:</b>
<div class="workaround">Replace <code>str[x..y]</code> with <code>str.terminal(str.size - x).initial(y - x + 1)</code> and <code>str[x...]</code> with <code>str.terminal(str.size - x)</code></div>
</div>

