---
layout: reference
title: Reference
tab: documentation
unique_id: docspage
author: Tom Bentley
doc_root: ..
---

# #{page.title}

This page lists concepts and links to their descriptions. The complete 
[language specification](#{page.doc_root}/spec) is also available.

_Some of these pages are incomplete. Want to help? [See how](/code/website)._

## Structure and Declarations

<ul class="linear">
  <li><a href="structure/keyword/">Keywords</a></li>
  <li><a href="structure/module/">Modules</a></li>
  <li><a href="structure/package/">Packages</a></li>
  <li><a href="structure/compilation-unit/">Compilation units</a></li>
  <li><a href="structure/type/">Types</a></li>
  <li><a href="structure/type-abbreviation/">Type abbreviations</a></li>
  <li><a href="structure/class/">Classes</a></li>
  <li><a href="structure/interface/">Interfaces</a></li>
  <li><a href="structure/parameter-list/">Parameters</a></li>
  <li><a href="structure/type-parameters/">Type parameters</a></li>
  <li><a href="structure/alias/">Type aliases</a></li>
  <li><a href="structure/value/">Values</a></li>
  <li><a href="structure/function/">Functions</a></li>
  <li><a href="structure/object/"><code>object</code>s</a></li>
  <li><a href="structure/annotation/">Annotations</a></li>
</ul>

## Annotations

<ul class="linear">
  <li><a href="annotation/abstract/"><code>abstract</code></a></li>
  <li><a href="annotation/actual/"><code>actual</code></a></li>
  <li><a href="annotation/annotation/"><code>annotation</code></a></li>
  <li><a href="annotation/default/"><code>default</code></a></li>
  <li><a href="annotation/deprecated/"><code>deprecated</code></a></li>
  <li><a href="annotation/doc/"><code>doc</code></a></li>
  <li><a href="annotation/by/"><code>by</code></a></li>
  <li><a href="annotation/formal/"><code>formal</code></a></li>
  <li><a href="annotation/final/"><code>final</code></a></li>
  <li><a href="annotation/late/"><code>late</code></a></li>
  <li><a href="annotation/license/"><code>license</code></a></li>
  <li><a href="annotation/native/"><code>native</code></a></li>
  <li><a href="annotation/optional/"><code>optional</code></a></li>
  <li><a href="annotation/see/"><code>see</code></a></li>
  <li><a href="annotation/shared/"><code>shared</code></a></li>
  <li><a href="annotation/throws/"><code>throws</code></a></li>
  <li><a href="annotation/tagged/"><code>tagged</code></a></li>
  <li><a href="annotation/variable/"><code>variable</code></a></li>
</ul>
          
<p><a href="annotation/markdown/">Markdown reference</a> for documentation annotations</p>
          
## Statements

<ul class="linear">
  <li><a href="statement/assert/"><code>assert</code></a></li>
  <li><a href="statement/break/"><code>break</code></a></li>
  <li><a href="statement/continue/"><code>continue</code></a></li>
  <li><a href="statement/conditions/">condition lists</a></li>
  <li><a href="statement/expression/">expression statements</a></li>
  <li><a href="statement/for/"><code>for</code></a></li>
  <li><a href="statement/if/"><code>if</code></a></li>
  <li><a href="statement/import/"><code>import</code></a></li>
  <li><a href="statement/return/"><code>return</code></a></li>
  <li><a href="statement/specification/"><code>=</code> (specification) statement</a></li>
  <li><a href="statement/switch/"><code>switch</code></a></li>
  <li><a href="statement/throw/"><code>throw</code></a></li>
  <li><a href="statement/try/"><code>try</code></a></li>
  <li><a href="statement/while/"><code>while</code></a></li>
</ul>

<p><a href="statement/block/">Statement blocks</a></p>

## Expressions

[Expressions](expression/)

<ul class="linear">
  <li><a href="expression/invocation/">Invocation</a></li>
  <li><a href="expression/tuple/">tuple enumeration</a></li>
  <li><a href="expression/iterable/">iterable enumeration</a></li>
  <li><a href="expression/string-template/">String template</a></li>
  <li><a href="expression/this/"><code>this</code></a></li>
  <li><a href="expression/outer/"><code>outer</code></a></li>
  <li><a href="expression/super/"><code>super</code></a></li>
  <li><a href="expression/package/"><code>package</code> qualifier</a></li>
  <li><a href="expression/anonymous-function/">anonymous functions</a></li>
  <li><a href="expression/callable-reference/"><code>Callable</code> references</a></li>
  <li><a href="expression/static-reference/">static references</a></li>
  <li><a href="expression/meta-reference/">meta references</a></li>
</ul>

Also see [operators](#operators) and [literals](#literals) below.

## Operators

<ul class="linear">
  <li><a href="operator/not/"><code>!</code>   (not)</a></li>
  <li><a href="operator/not-equal/"><code>!=</code>  (not equal)</a></li>
  <li><a href="operator/remainder/"><code>%</code>   (remainder)</a></li>
  <li><a href="operator/remainder-assign/"><code>%=</code>  (remainder assign)</a></li>
  <li><a href="operator/intersection/"><code>&amp;</code>   (Set intersection)</a></li>
  <li><a href="operator/and/"><code>&amp;&amp;</code>  (and)</a></li>
  <li><a href="operator/and-assign/"><code>&amp;&amp;=</code> (and assign)</a></li>
  <li><a href="operator/intersect-assign/"><code>&amp;=</code>  (Set intersect assign)</a></li>
  <li><a href="operator/invoke/"><code>()</code>  (invoke)</a></li>
  <li><a href="operator/nullsafe-invoke/"><code>()</code>  (null-safe invoke)</a></li>
  <li><a href="operator/product/"><code>*</code>   (product)</a></li>
  <li><a href="operator/scale/"><code>**</code>  (scale)</a></li>
  <li><a href="operator/multiply-assign/"><code>*=</code>  (multiply assign)</a></li>
  <li><a href="operator/sum/"><code>+</code>   (sum)</a></li>
  <li><a href="operator/unary_plus/"><code>+</code>   (unary plus)</a></li>
  <li><a href="operator/increment/"><code>++</code>  (increment)</a></li>
  <li><a href="operator/add-assign/"><code>+=</code>  (add assign)</a></li>
  <li><a href="operator/difference/"><code>-</code>   (difference)</a></li>
  <li><a href="operator/unary_minus/"><code>-</code>   (unary minus)</a></li>
  <li><a href="operator/decrement/"><code>--</code>  (decrement)</a></li>
  <li><a href="operator/subtract-assign/"><code>-=</code>  (subtract assign)</a></li>
  <li><a href="operator/entry/"><code>-&gt;</code>  (entry)</a></li>
  <li><a href="operator/member/"><code>.</code>   (member)</a></li>
  <li><a href="operator/spanned-range/"><code>..</code>  (spanned range)</a></li>
  <li><a href="operator/segmented-range/"><code>:</code>   (segmented range)</a></li>
  <li><a href="operator/quotient/"><code>/</code>   (quotient)</a></li>
  <li><a href="operator/divide-assign/"><code>/=</code>  (divide assign)</a></li>
  <li><a href="operator/less-than/"><code>&lt;</code>   (less than)</a></li>
  <li><a href="operator/less-than-or-equal/"><code>&lt;=</code>  (less than or equal)</a></li>
  <li><a href="operator/compare/"><code>&lt;=&gt;</code> (compare)</a></li>
  <li><a href="operator/assign/"><code>=</code>   (assign)</a></li>
  <li><a href="operator/equal/"><code>==</code>  (equal)</a></li>
  <li><a href="operator/identical/"><code>===</code> (identical)</a></li>
  <li><a href="operator/greater-than/"><code>&gt;</code>   (greater than)</a></li>
  <li><a href="operator/greater-than-or-equal/"><code>&gt;=</code>  (greater than or equal)</a></li>
  <li><a href="operator/lookup/"><code>[]</code>  (lookup)</a></li>
  <li><a href="operator/spread-attribute/"><code>*.</code> (spread attribute)</a></li>
  <li><a href="operator/spread-invoke/"><code>*.</code> (spread invoke)</a></li>
  <li><a href="operator/span/"><code>x[y..z]</code> (span)</a></li>
  <li><a href="operator/upper-span/"><code>x[y...]</code> (upper span)</a></li>
  <li><a href="operator/lower-span/"><code>x[...z]</code> (lower span)</a></li>
  <li><a href="operator/segment/"><code>x[y:n]</code>  (segment)</a></li>
  <li><a href="operator/power/"><code>^</code>   (power)</a></li>
  <li><a href="operator/in/"><code>in</code>  (in)</a></li>
  <li><a href="operator/is/"><code>is</code>  (is)</a></li>
  <li><a href="operator/union/"><code>|</code>   (Set union)</a></li>
  <li><a href="operator/union-assign/"><code>|=</code>  (Set union assign)</a></li>
  <li><a href="operator/or/"><code>||</code>  (or)</a></li>
  <li><a href="operator/or-assign/"><code>||=</code> (or assign)</a></li>
  <li><a href="operator/invoke/"><code>{}</code>  (invoke)</a></li>
  <li><a href="operator/nullsafe-invoke/"><code>{}</code>  (null-safe invoke)</a></li>
  <li><a href="operator/complement/"><code>~</code>   (Set complement)</a></li>
  <li><a href="operator/complement-assign/"><code>~=</code>  (Set complement assign)</a></li>
  <li><a href="operator/else/"><code>else</code></a></li>
  <li><a href="operator/then/"><code>then</code></a></li>
</ul>

<p><a href="operator/operator-polymorphism/">operator polymorphism</a></p>


## Literals

<ul class="linear">
  <li><a href="literal/integer/"><code>Integer</code> literals</a></li>
  <li><a href="literal/float/"><code>Float</code> literals</a></li>
  <li><a href="literal/string/"><code>String</code> literals</a></li>
  <li><a href="literal/character/"><code>Character</code> literals</a></li>
</ul>

## Language module (`ceylon.language`)

The API documentation for [`ceylon.language`](#{site.urls.apidoc_current}/index.html).

## Tools

<ul class="linear">
  <li>The <code>ceylon</code> command, <a href="tool/ceylon/"><code>ceylon</code></a></li>
  <li>An index of <a href="#{site.urls.ceylon_tool_current}/index.html"><code>ceylon</code> subcommands</a></li>
  <li>The Ceylon <a href="tool/ant/"><code>Ant</code> tasks</a></li>
  <li>The <a href="tool/config/">configuration file format</a></li>
</ul>

## Interoperability

* [Calling Ceylon from Java](interoperability/ceylon-from-java/)
* [Calling Java from Ceylon](interoperability/java-from-ceylon/)
* [Type mapping](interoperability/type-mapping/)
* [The JavaScript compiler](interoperability/js/)

## Module repositories

* [Module repositories](repository/)
* [`modules.ceylon-lang.org` aka Ceylon Herd](repository/modules.ceylon-lang.org)
* The [ceylon SDK](https://modules.ceylon-lang.org/categories/SDK)


