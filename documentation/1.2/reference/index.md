---
layout: reference12
title_md: Reference
tab: documentation
unique_id: docspage
author: Tom Bentley
doc_root: ..
---

# #{page.title_md}

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
  <li><a href="structure/type-declaration/">Type Declarations</a></li>
  <li><a href="structure/type-parameters/">Type parameters</a></li>
  <li><a href="structure/alias/">Type aliases</a></li>
  <li><a href="structure/interface/">Interfaces</a></li>
  <li><a href="structure/class/">Classes</a></li>
  <li><a href="structure/parameter-list/">Parameters</a></li>
  <li><a href="structure/value/">Values</a></li>
  <li><a href="structure/function/">Functions</a></li>
  <li><a href="structure/object/"><code>object</code> declarations</a> 
      <small>(c.f. <a href="expression/object/">object expressions</a>)</small></li>
  <li><a href="structure/annotation/">Annotations</a></li>
</ul>

## Annotations

<ul class="linear">
  <li><a href="annotation/abstract/"><code>abstract</code></a></li>
  <li><a href="annotation/actual/"><code>actual</code></a></li>
  <li><a href="annotation/aliased/"><code>aliased</code></a></li>
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
  <li><a href="annotation/sealed/"><code>sealed</code></a></li>
  <li><a href="annotation/see/"><code>see</code></a></li>
  <li><a href="annotation/serializable/"><code>serializable</code></a></li>
  <li><a href="annotation/shared/"><code>shared</code></a></li>
  <li><a href="annotation/suppressWarnings/"><code>suppressWarnings</code></a></li>
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
  <li><a href="statement/conditions/">Condition lists</a></li>
  <li><a href="statement/expression/">Expression statements</a></li>
  <li><a href="statement/for/"><code>for</code></a></li>
  <li><a href="statement/if/"><code>if</code> statement</a></li>
  <li><a href="statement/import/"><code>import</code></a></li>
  <li><a href="statement/return/"><code>return</code></a></li>
  <li><a href="statement/specification/">Specification statements</a></li>
  <li><a href="statement/destructure/">Destructuring specification</a></li>
  <li><a href="statement/switch/"><code>switch</code> statement</a></li>
  <li><a href="statement/throw/"><code>throw</code></a></li>
  <li><a href="statement/try/"><code>try</code></a></li>
  <li><a href="statement/while/"><code>while</code></a></li>
</ul>

<p><a href="statement/block/">Statement blocks</a></p>

## Expressions

[Expressions](expression/)

<ul class="linear">
  <li><a href="expression/invocation/">Invocation</a></li>
  <li><a href="expression/tuple/">Tuple enumeration</a></li>
  <li><a href="expression/iterable/">Iterable enumeration</a></li>
  <li><a href="expression/string-template/">String templates</a></li>
  <li><a href="expression/this/"><code>this</code></a></li>
  <li><a href="expression/outer/"><code>outer</code></a></li>
  <li><a href="expression/super/"><code>super</code></a></li>
  <li><a href="expression/package/"><code>package</code> qualifier</a></li>
  <li><a href="expression/anonymous-function/">Anonymous functions</a></li>
  <li><a href="expression/callable-reference/">Callable references</a></li>
  <li><a href="expression/static-reference/">Static references</a></li>
  <li><a href="expression/meta-reference/">Meta references</a></li>
  
  <li><a href="expression/if/"><code>if</code> expressions</a></li>
  <li><a href="expression/switch/"><code>switch</code> expressions</a></li>
  <li><a href="expression/let/"><code>let</code></a></li>
  <li><a href="expression/object/"><code>object</code> expressions</a></li>
</ul>

Also see [operators](#operators) and [literals](#literals) below

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
  <li><a href="operator/measured-range/"><code>y:z</code> (measured range)</a></li>
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
  <li><a href="operator/nullsafe-member/"><code>?.</code>   (null-safe attribute)</a></li>
  <li><a href="operator/nullsafe-method/"><code>?.</code>   (null-safe method)</a></li>
  <li><a href="operator/lookup/"><code>[]</code>  (lookup)</a></li>
  <li><a href="operator/spread/"><code>*</code> (spread)</a></li>
  <li><a href="operator/spread-attribute/"><code>*.</code> (spread attribute)</a></li>
  <li><a href="operator/spread-invoke/"><code>*.</code> (spread method)</a></li>
  <li><a href="operator/span/"><code>x[y..z]</code> (span)</a></li>
  <li><a href="operator/upper-span/"><code>x[y...]</code> (upper span)</a></li>
  <li><a href="operator/lower-span/"><code>x[...z]</code> (lower span)</a></li>
  <li><a href="operator/measure/"><code>x[y:z]</code> (measure)</a></li>
  <li><a href="operator/power/"><code>^</code>   (power)</a></li>
  <li><a href="operator/union/"><code>|</code>   (Set union)</a></li>
  <li><a href="operator/union-assign/"><code>|=</code>  (Set union assign)</a></li>
  <li><a href="operator/or/"><code>||</code>  (or)</a></li>
  <li><a href="operator/or-assign/"><code>||=</code> (or assign)</a></li>
  <li><a href="operator/invoke/"><code>{}</code>  (invoke)</a></li>
  <li><a href="operator/complement/"><code>~</code>   (Set complement)</a></li>
  <li><a href="operator/complement-assign/"><code>~=</code>  (Set complement assign)</a></li>
  <li><a href="operator/else/"><code>else</code></a></li>
  <li><a href="operator/exists/"><code>exists</code></a></li>
  <li><a href="operator/in/"><code>in</code></a></li>
  <li><a href="operator/is/"><code>is</code></a></li>
  <li><a href="operator/nonempty/"><code>nonempty</code></a></li>
  <li><a href="operator/of/"><code>of</code></a></li>
  <li><a href="operator/then/"><code>then</code></a></li>
</ul>

<p><a href="operator/operator-polymorphism/">Operator polymorphism</a></p>


## Literals

<ul class="linear">
  <li><a href="literal/integer/"><code>Integer</code> literals</a></li>
  <li><a href="literal/float/"><code>Float</code> literals</a></li>
  <li><a href="literal/string/"><code>String</code> literals</a></li>
  <li><a href="literal/character/"><code>Character</code> literals</a></li>
</ul>

## API docs for `ceylon.language` and the Ceylon SDK

The API documentation for 

* [`ceylon.language`](#{site.urls.apidoc_current_language})
* [`ceylon.collection`](#{site.urls.apidoc_current_collection})
* [`ceylon.dbc`](#{site.urls.apidoc_current_dbc})
* [`ceylon.file`](#{site.urls.apidoc_current_file})
* [`ceylon.html`](#{site.urls.apidoc_current_html})
* [`ceylon.interop.java`](#{site.urls.apidoc_current_interop_java})
* [`ceylon.io`](#{site.urls.apidoc_current_io})
* [`ceylon.json`](#{site.urls.apidoc_current_json})
* [`ceylon.locale`](#{site.urls.apidoc_current_locale})
* [`ceylon.logging`](#{site.urls.apidoc_current_logging})
* [`ceylon.math`](#{site.urls.apidoc_current_math})
* [`ceylon.net`](#{site.urls.apidoc_current_net})
* [`ceylon.process`](#{site.urls.apidoc_current_process})
* [`ceylon.promise`](#{site.urls.apidoc_current_promise})
* [`ceylon.regex`](#{site.urls.apidoc_current_regex})
* [`ceylon.test`](#{site.urls.apidoc_current_test})
* [`ceylon.time`](#{site.urls.apidoc_current_time})
* [`ceylon.transaction`](#{site.urls.apidoc_current_transaction})
* [`ceylon.unicode`](#{site.urls.apidoc_current_unicode})

## Tools

* The `ceylon` command, [`ceylon`](tool/ceylon/)
* An index of [`ceylon`](#{site.urls.ceylon_tool_current}/index.html) subcommands
* `ceylon` [command plugins](tool/plugin/)
* The Ceylon [`ant`](tool/ant/) tasks
* The [configuration file format](tool/config/)

## Interoperability

* [Calling Ceylon modules on the JVM](interoperability/ceylon-on-jvm/)
* [Calling Ceylon from Java](interoperability/ceylon-from-java/)
* [Calling Java from Ceylon](interoperability/java-from-ceylon/)
* [Type mapping](interoperability/type-mapping/)
* [The JavaScript compiler](interoperability/js/)

## Module repositories

* [Module repositories](repository/)
* [`modules.ceylon-lang.org` aka Ceylon Herd](repository/modules.ceylon-lang.org)
* The [ceylon SDK](https://modules.ceylon-lang.org/categories/SDK)


