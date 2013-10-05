---
title: Key Features
layout: default
tab: features
unique_id: keyfeaturespage
author: Gavin King
---
<h1 style="text-align:center">Key features of Ceylon</h1>
<div style="margin-left:15%;margin-right:15%;text-shadow: 0 -1px 1px #ffffff;padding-bottom:10px;">
<p style="margin-left:15%;margin-right:15%;text-align:center">
Ceylon is a language for writing large programs in teams.<br/> 
Here's some of what's special about it.</p>

<div class="feature">
<h2>Cross-platform execution</h2>
<p>Ceylon programs execute on Java and JavaScript virtual machines, and can 
easily <a href="/documentation/current/introduction/#interoperation_with_native_java_and_javascript">
interoperate with native code</a>.</p>
<div><img src="/images/features/javajs1.png" style="box-shadow: 0 0 15px #888;"/>
<img src="/images/features/javajs2.png" style="box-shadow: 0 0 15px #888;"/></div>
</div>

<div style="text-align:right" class="feature">
<h2>Platform libraries</h2>
<p>Ceylon provides a brand-new 
<a href="https://modules.ceylon-lang.org/categories/SDK">modular SDK</a>.</p>
<div>
<img src="/images/features/herd.png" style="box-shadow: 0 0 15px #888;"/>
<img src="/images/features/sdk2.png" style="box-shadow: 0 0 15px #888;"/>
</div>
</div>

<div class="feature">
<h2>Modularity</h2>
<p>Code is organized into 
<a href="/documentation/current/introduction/#modularity">packages and modules</a>, 
and compiled to module archives.The tooling supports a system of module repositories, 
with <a href="http://modules.ceylon-lang.org">Ceylon Herd</a> as its social focus point.</p>
<div>
<img src="/images/features/modularity2.png" style="box-shadow: 0 0 15px #888;"/>
</div>
<div style="text-align:right">
<img src="/images/features/modularity.png" style="box-shadow: 0 0 15px #888;"/>
</div>
</div>

<div style="text-align:right" class="feature">
<h2>Tooling</h2>
<p>Ceylon has a full-featured 
<a href="/documentation/current/ide">Eclipse-based IDE</a> and excellent 
<a href="/documentation/current/reference/tool/ceylon/subcommands/">command-line 
tools</a>, with support for modularity baked right in.</p>
<div><img src="/images/features/tools1.png" style="box-shadow: 0 0 15px #888;"/></div>
</div>

<div class="feature">
<h2>Powerful type system</h2>
<p>The type system is especially clean, elegant, and powerful, featuring 
<a href="/documentation/current/introduction/#principal_typing_union_types_and_intersection_types">
intersection and union types</a> as basic building blocks, along with 
<a href="/documentation/current/introduction/#enumerated_subtypes">enumerated types</a> 
and <a href="/documentation/current/introduction/#type_aliases_and_type_inference">type aliases</a>.</p>
<div>
<img src="/images/features/enumerated.png" style="box-shadow: 0 0 15px #888;"/>
</div>
<div>
<img src="/images/features/unionintersection.png" style="box-shadow: 0 0 15px #888;"/>
</div>
</div>

<div style="text-align:right" class="feature">
<h2>Object-oriented programming</h2>
<p>Programming with objects is a breeze. Everything is an object, even numeric values,
even the null value, even a function or class. Handle collections with 
<a href="/documentation/current/introduction/#higher_order_functions">higher-order functions</a> 
and <a href="/documentation/current/introduction/#comprehensions">comprehensions</a>. 
Model difficult relationships with 
<a href="/documentation/current/introduction/#mixin_inheritance">mixin inheritance</a>.</p>
<div><img src="/images/features/heirarchy.png" style="box-shadow: 0 0 15px #888;"/></div>
</div>

<div class="feature">
<h2>Type inference, flow-dependent typing, and typesafe <code>null</code></h2>
<p>Ceylon is more typesafe than other languages, but you write down fewer types: the 
language features 
<a href="/documentation/current/introduction/#type_aliases_and_type_inference">local
type inference</a>, 
<a href="/documentation/current/introduction/#typesafe_null_and_flow_dependent_typing">
flow-dependent typing</a>, a typesafe <code>null</code>
value, and a typesafe <code>switch</code> statement.</p>
<div>
<img src="/images/features/flowtyping.png" style="box-shadow: 0 0 15px #888;"/>
<img src="/images/features/null.png" style="vertical-align:top;box-shadow: 0 0 15px #888;"/>
</div>
</div>

<div style="text-align:right" class="feature">
<h2>Simplified generics with fully-reified types</h2>
<p>Generics that don't suck: Ceylon 
<a href="/documentation/current/introduction/#simplified_generics_with_fully_reified_types">"fixes" 
generics</a> with declaration-site covariance and contravariance, reified type arguments, and 
principal instantiation inheritance.</p>
<img src="/images/features/generics.png" style="vertical-align:top;box-shadow: 0 0 15px #888;"/>
</div>

<div class="feature">
<h2>Typesafe metaprogramming</h2>
<p><a href="/documentation/current/tour/annotations/#annotations">Annotations</a>, a 
<a href="/documentation/current/tour/annotations/#the_metamodel">typesafe metamodel</a>,
and reified generics are the foundation of Ceylon's unique approach to typesafe 
runtime metaprogramming, which makes framework development a pleasure.</p>
</div>

<!-- TODO: named args + tree structures -->

<p style="margin-left:15%;margin-right:15%;text-align:center">
To learn more, start with the 
<a href="/documentation/current/introduction">quick introduction</a>.</p>

</div>