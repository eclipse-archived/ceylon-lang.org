---
layout: reference13
title_md: EE-mode
tab: documentation
unique_id: docspage
author: Tom Bentley
---

# #{page.title_md}

Since Ceylon 1.3.1 the JVM compiler has had a special "EE-mode" to ease interoperability
with Java-EE-like environments where classes are instantiated and manipulated by 
frameworks.

## `final` method modifier

Normally the ceylon compiler wil generate `final` methods for elements which subclasses should 
not be able to override. This makes it safer to subclass a Ceylon class in Java.

In EE mode, classes are generated without having the `final` modifier on their methods.

The rationale for this is to make these classes proxiable by runtime bytecode generation.

## `public ` nullary constructor

Normally the Ceylon compiler will generate a nullary constructor because 
[Ceylon classes are implicitly `java.io.Serializable`](../java-from-ceylon/#java.io.Serializable), 
and so must have a non-`private` nullary constructor.

In EE mode, this constructor is made `public`.

The rationale for this is to make classes usable with JAX-RS.

## `late` initialization checking

Normally the Ceylon compiler will add runtime checks to the getters and setters for `late`
attributes to prevent those attributes from being used before they've been initialized, 
or to prevent them from being reinitialized if they're not `variable`. 
In many cases this runtime check can simply use the null-ness of the underlying field to 
detect access before initialization, or reinitialization. In other cases, specifically
when the attribute gets transformed into a primitive-typed field, or the attribute has a nullable type, 
it is necessary to use an extra `boolean` field to track the initialization of the attribute's field.

In EE mode the compiler omits runtime initialization checks which would require an 
extra `boolean` field.

The rationale for this is that frameworks will inject the attribute directly into the field 
(not via the setter), and don't know about the boolean state tracking field, meaning that 
without EE-mode a Ceylon class would 
incorrectly throw an initialization exception.

## Java types for "optional primitive" fields

Normally the Ceylon compiler will tranform an attribute of type `Integer` to a `long` field, and an attribute of type
`Integer?` to a field of type `ceylon.language.Integer` (which, being a reference type, can be null). Similarly Ceylon 
boxes are also used for `String?`, `Float?`, `Character?`, `Boolean?` and `Byte?` 
(see [type mapping](../type-mapping/) for details).

In EE mode such fields are of the equivalent Java boxed primitive types
`java.lang.Long`, `java.lang.String`, `java.lang.Double`, `java.lang.Character`, 
`java.lang.Boolean` and `java.lang.Byte` respectively.

The rationale for this is that frameworks injecting field state typcially understand these types without 
needing special adapter classes to be written.

## Java types for `List`, `Set` and `Map`

Normally the Ceylon compiler will transform an attribute of type `ceylon.language::List<Element>` 
to a field of that type. Likewise `ceylon.language::Set<Element>` and `ceylon.language::Map<Key,Item>` .

In EE mode such fields are of type `java.util.List`, `java.util.Set` and `java.util.Map` respectively. 
The compiler wraps a Ceylon collection in an adapter on set and unwraps, or rewraps on get. 
Such wrapping and rewrapping applies to arbitrary nesting of these collections, so long as the 
static types are `ceylon.language::List<Element>`, `ceylon.language::Set<Element>` or `ceylon.language::Map<Key,Item>` .

Moreover an attribute of static type `ceylon.language::List<Integer>`  is stored in a field of type
`java.util.List<java.lang.Long>`, and likewise for the other "primitive" types and the other 
collections.

For example:

    class Example() {
        shared late List<Integer> list; // java.util.List<java.lang.Long>
        shared late Map<String, List<String>> map; // java.util.Map<java.lang.String, java.util.List<java.lang.String>>
        shared late MutableSet<String> set; // EE-mode mapping does not apply, because the static type is not Set
    }

The rationale for this is that frameworks injecting field state typcially understand these types without 
needing special adapter classes to be written.

## Activating EE mode

EE mode is activated for all classes in a module when `javax.javaeeapi` or equivalently  `maven:"javax:javaee-api"` (any version) is imported in the `module.ceylon`.

EE mode is also activated for a class when that class is annotated with any of the following:

*  `javax.xml.bind.annotation.XmlAccessorType`
* `javax.persistence.Entity`
* `javax.inject.Inject`
* `javax.ejb.Stateless`
* `javax.ejb.Stateful`
* `javax.ejb.MessageDriven`
* `javax.ejb.Singleton`

If necessary, the compiler options 
[`--ee-annotation`](../../tool/ceylon/subcommands/ceylon-compile.html#option--ee-annotation) and 
[`--ee-import`](../../tool/ceylon/subcommands/ceylon-compile.html#option--ee-import) can be used to replace
the fully qualified annotation type names and module names which trigger activation.

Alternatively the option 
[`--ee`](../../tool/ceylon/subcommands/ceylon-compile.html#option--ee)
can be used to enable EE mode for the entire compilation.

These options can also be specified in your 
[`.ceylon/config`](../../tool/config/#_compiler_backend_section) file, for example

<!-- lang: none -->
    [compiler.jvm]
    eeimport=mvn:"org.springframework.boot:spring-boot"
    eeannotation=org.springframework.beans.factory.annotation.Autowired
    

