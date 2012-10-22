---
title: Known issues in M3
layout: known-issues
toc: true
tab: documentation
unique_id: docspage
author: Stephane Epardaud
---

[However many tests we have](/blog/2012/02/02/how-we-test-ceylon/) in Ceylon, we managed to find 
several bugs after we [released M3.1](/blog/2012/07/09/ceylon-m3.1-v2000/).
We're not happy about this, but hey, that's the way it is, so while we're busy squashing them
in our code repository, the fact is you will need to use workarounds for them until we build
a new release.

In order to make it easier for you to figure out if you hit a known M3.1 bug, and how best to
work around it, we've made a list. Check it out, and if you can't find your bug, don't hesitate
to [report it](/code/issues/). 

## Compiler (<code>ceylon compile</code>)

<div class="known-issue">
<a class="see" href="https://github.com/ceylon/ceylon-compiler/issues/470">See issue</a>
<div class="title"><code>ceylon compile</code> fails to compile module if Java classes and Ceylon classes depend on one another</div>
<b>Workaround:</b>
<div class="workaround">None</div>
</div>

<div class="known-issue">
<a class="see" href="https://github.com/ceylon/ceylon-compiler/issues/651">See issue</a>
<div class="title">Refinement and intersection types</div>
<b>Workaround:</b>
<div class="workaround">None</div>
</div>

<div class="known-issue">
<a class="see" href="https://github.com/ceylon/ceylon-compiler/issues/602">See issue</a>
<div class="title">Problem with toplevels `x` and `X` in same package on case-insensitive filesystems</div>
<b>Workaround:</b>
<div class="workaround">Don't define toplevel members of the same package whose names differ only by case.</div>
</div>

## Documentation generator (<code>ceylon doc</code>)

No known issue.

## SDK (<code>ceylon.language</code> and other platform modules)

No known issue.

