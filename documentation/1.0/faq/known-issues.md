---
title: Known issues in M3
layout: known-issues
toc: true
tab: documentation
unique_id: docspage
author: Stephane Epardaud
---

[However many tests we have](/blog/2012/02/02/how-we-test-ceylon/) in Ceylon, we managed to find 
several bugs after we [released M3](/blog/2012/03/20/ceylon-m2-minitel/).
We're not happy about this, but hey, that's the way it is, so while we're busy squashing them
in our code repository, the fact is you will need to use workarounds for them until we build
a new release.

In order to make it easier for you to figure out if you hit a known M3 bug, and how best to
work around it, we've made a list. Check it out, and if you can't find your bug, don't hesitate
to [report it](/code/issues/). 

## Compiler (<code>ceylonc</code>)

<div class="known-issue">
<a class="see" href="https://github.com/ceylon/ceylon-compiler/issues/470">See issue</a>
<div class="title"><code>ceylonc</code> fails to compile module if Java classes and Ceylon classes depend on one another</div>
<b>Workaround:</b>
<div class="workaround">None</div>
</div>

## Documentation generator (<code>ceylond</code>)

No known issue.

## SDK (<code>ceylon.language</code>)

No known issue.

