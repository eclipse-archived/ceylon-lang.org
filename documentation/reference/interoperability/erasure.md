---
layout: reference
title: Erasure rules
tab: documentation
author: Tom Bentley
---

# #{page.title}

On this page by *erasure* we mean the difference between Ceylon types at 
compile time and the corresponding Java types used at runtime. The Ceylon 
compiler is responsible for implementing the rules but the rules are
largely constructed on the basis of 'the simplest thing that could possibly 
work'. Even so, the rules are sometimes complex.

## Reification

The Ceylon compiler *reifies* Ceylon types. This means it stores 
the full type information, including generic type parameters within the 
compiled code. It does this using Java annotations 
(with runtime retention). This is why it doesn't matter that the 
mappings in the table below are not one-to-one: The Ceylon compiler and runtime 
can always inspect the annotations to determine detailed (Ceylon) type 
information.

## Basic erasure rules

In general **the following table is a simplification** because the actual 
erasure rules depend on how the type is being used. For example a 
Ceylon type may erase to one Java type when used in a method return type 
and a *different* Java type when used in an `extends` or `satisifes` clause. 

A concrete example of this would `ceylon.language.Natural`, which erases to 
`int` in most places, but when used as a generic type parameter, it
has to erase to `java.lang.Integer` because a primitive type is not 
permitted as a type parameter in Java.

Please note: **These erasure rules are subject to change as the compiler develops.**

<table>
  <tbody>
    <tr>
      <th>Ceylon type</th>
      <th>Runtime type</th>
    </tr>
    <tr>
      <td><code>ceylon.language.Void</code></td>
      <td><code>java.lang.Object</code></td>
    </tr>
    <tr>
      <td><code>ceylon.language.Object</code></td>
      <td><code>java.lang.Object</code></td>
    </tr>
    <tr>
      <td><code>ceylon.language.Nothing</code></td>
      <td><code>java.lang.Object</code></td>
    </tr>
    <tr>
      <td><code>ceylon.language.Boolean</code></td>
      <td><code>boolean</code></td>
    </tr>
    <tr>
      <td><code>ceylon.language.Boolean?</code></td>
      <td><code>ceylon.language.Boolean</code></td>
    </tr>
    <tr>
      <td><code>ceylon.language.Integer</code></td>
      <td><code>int</code><a href="#note1"><sup>1</sup></a></td>
    </tr>
    <tr>
      <td><code>ceylon.language.Integer?</code></td>
      <td><code>ceylon.language.Integer</code></td>
    </tr>
    <tr>
      <td><code>ceylon.language.Natural</code></td>
      <td><code>long</code></td>
    </tr>
    <tr>
      <td><code>ceylon.language.Natural?</code></td>
      <td><code>long</code></td>
    </tr>
    <tr>
      <td><code>ceylon.language.Whole</code></td>
      <td><code>java.math.BigInteger</code><a href="#noteM1"><sup>&gt;M1</sup></a></td>
    </tr>
    <tr>
      <td><code>ceylon.language.Whole?</code></td>
      <td><code>java.math.BigInteger</code><a href="#noteM1"><sup>&gt;M1</sup></a></td>
    </tr>
    <tr>
      <td><code>ceylon.language.Float</code></td>
      <td><code>double</code></td>
    </tr>
    <tr>
      <td><code>ceylon.language.Float?</code></td>
      <td><code>ceylon.language.Float</code></td>
    </tr>
    <tr>
      <td><code>ceylon.language.Decimal</code></td>
      <td><code>java.math.BigDecimal</code><a href="#noteM1"><sup>&gt;M1</sup></a></td>
    </tr>
    <tr>
      <td><code>ceylon.language.Decimal?</code></td>
      <td><code>java.math.BigDecimal</code><a href="#noteM1"><sup>&gt;M1</sup></a></td>
    </tr>
    <tr>
      <td><code>ceylon.language.Character</code></td>
      <td><code>char</code></td>
    </tr>
    <tr>
      <td><code>ceylon.language.Character?</code></td>
      <td><code>ceylon.language.Character</code></td>
    </tr>
    <tr>
      <td><code>ceylon.language.String</code></td>
      <td><code>java.lang.String</code></td>
    </tr>
    <tr>
      <td><code>ceylon.language.String?</code></td>
      <td><code>ceylon.language.String</code></td>
    </tr>
    <tr>
      <td><code>ceylon.language.Exception</code></td>
      <td><code>ceylon.language.Exception</code> (in instantiations and <code>extends</code> clauses)<br/>
      <code>java.lang.Exception</code> (in <code>catch</code> clauses)<br/>
      <code>java.lang.Throwable</code> (everywhere else)</td>
    </tr>
    <tr>
      <td><code>ceylon.language.Sequence</code> (default impl)</td>
      <td><code>ceylon.language.ArraySequence</code><a href="#noteNonLang"><sup>Non-language</sup></a></td>
    </tr>
  </tbody>
</table>

All other types are not erased.

Notes:
<table>
  <tbody>
    <tr>
      <td><a name="noteM1"><sup>&gt;M1</sup></a></td>
      <td>This is not implemented in M1.</td>
    </tr>
    <tr>
      <td><a name="note1"><sup>1</sup></a></td>
      <td>This will be `long` after M1.</td>
    </tr>
    <tr>
      <td><a name="noteNonLang"><sup>Non-language</sup></a></td>
      <td>This type is not considered part of the 
      <code>ceylon.language</code> module.</td>
    </tr>
  </tbody>
</table>


## See also

* The [annotations](../annotations) used for reification

