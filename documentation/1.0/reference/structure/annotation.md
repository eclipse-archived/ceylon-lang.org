---
layout: reference
title: Annotations
tab: documentation
unique_id: docspage
author: Tom Bentley
doc_root: ../../..
---

# #{page.title}

An annotation encodes metadata about a [program element](#program_elements).

## Usage 

Some example annotation declarations:

<!-- check:none -->
    shared Deprecated deprecated() {
        return Deprecated();
    }
    shared Description doc(String description) {
        return Description(description);
    }
    shared Authors by(String* authors) {
        return Authors (*authors);
    }

## Description

An annotation is composed of two parts:

* an annotation `class`, which is the type of the value that 
  the annotation has when it is obtained at runtime.

* an annotation constructor, which is used at development 
  time to annotate program elements.

A given annotation class can have zero, one or many annotation constructors.

### Annotation class declaration

An annotation class must be a toplevel class 
annotated with the `final` and `annotation` annotations 
and it must be a direct subclass of either 
[`Annotation`](#{site.urls.apidoc_current}/Annotation.type.html),
[`OptionalAnnotation`](#{site.urls.apidoc_current}/OptionalAnnotation.type.html) or 
[`SequencedAnnotation`](#{site.urls.apidoc_current}/SequencedAnnotation.type.html).

    final annotation class Example(shared String description) extends Annotation() {
    }
    
Any class parameters must be of one of the allowed types:

* `Integer`, `Character`, `Float`, `String`
* [Enumerated types](../type/#enumerated_types) where all the cases are `object` declarations
  (which includes `Boolean`).
* A subtype of [`Declaration`](#{site.urls.apidoc_current}/meta/declaration/Declaration.type.html)
* Another annotation class.
* `Iterable`s, `Sequence`s or `Tuple`s of the above.

There are no special constraints on the initialization or declaration sections of an annotation class. 
In particular the class parameters may be `shared` or not. 

### Annotation constructor declaration

An annotation constructor must be a [top-level](../type#top_level_declarations) [function](../function/) 
annotated with `annotation`, with a return type that is an [annotation class](#annotation_class_declaration). 

    annotation Example eg() => Example("");
    annotation Example example(String description="") => Example(description);

Any parameters must be of one of the permitted types for an annotation class (see above list).

The body of the annotation constructor is quite limited:

* The only permitted statement is a `return` statement, whose expression is the 
  instantiation of an annotation class.
* The arguments to the annotation class instantiation are limited to 
    * parameters of the constructor,
    * String, Character, Integer and Float literals,
    * the `object` cases of parameters of an enumerated type (e.g. `true` and `false`),
    * declaration literals (e.g. `` `class String` ``)
    * `Tuple` and `Iterable` enumerations of the above
    * Spread arguments of the above

Defaulted parameter expressions for constructor parameters are limited by the same rules as the 
annotation class instantiation arguments.

### Constraining Annotations

Annotation classes must be a subclass of `Annotation`. 

* Using `Annotation` as the superclass means the annotation class can be used on any 
  program element that supports annotations. The annotation may appear at most once. 
* `Annotation` has a subclass, [`ConstrainedAnnotation`](#{site.urls.apidoc_current}/metamodel/ConstrainedAnnotation.type.html),
  which allows more fine-grained control over where and how the annotation may be used. 
  Its enumerated subclasses are:
    * [`OptionalAnnotation`](#{site.urls.apidoc_current}/metamodel/OptionalAnnotation.type.html) 
      for annotations which occur at most once on a given program element, and
    * [`SequencedAnnotation`](#{site.urls.apidoc_current}/metamodel/SequencedAnnotation.type.html)
      which can occur more than once on a given program element.

### Program Elements

A `ConstrainedAnnotation` may constrain the program elements where it is allowed to 
be used to any of the types satisfying 
[`Annotated`](#{site.urls.apidoc_current}/metamodel/Annotated.type.html), which are

* [Class declarations](../class), [class aliases](../class#alises) and their [parameters](../parameter-list),
* [Interface declarations](../interface) and [interface alises](../interface#aliases)
* [Function declarations](../function) and their [parameters](../parameter-list)
* [Value declarations](../value)), and their setters
* [Module descriptors](../module#descriptor) and their `import`s.
* [Package descriptors](../package#descriptor)

### Using annotations

To use an annotation you preceed the program element with an invocation of the annotation constructor:

    example()
    class AnnotatedExample() {
        // ...
    }
    
    example("Annotating a function")
    void anotherExample() {
    }
    
    example{ description = "Annotating a function"; }
    String namedArguments => "Good, eh?";
    
As a special case, and to make 
it extra easy to write such documentation, annotating 
program elements with a `String` literal is a shortcut syntax for 
annotating the element with the `doc` annotation.

    "Some documentation about [[DocExample]]"
    class DocExample() {
        // ...
    }


### Language module annotations

* [`abstract`](#{site.urls.apidoc_current}/#abstract)
* [`actual`](#{site.urls.apidoc_current}/#actual)
* [`annotation`](#{site.urls.apidoc_current}/#annotation)
* [`default`](#{site.urls.apidoc_current}/#default)
* [`deprecated`](#{site.urls.apidoc_current}/#deprecated)
* [`doc`](#{site.urls.apidoc_current}/#doc)
* [`by`](#{site.urls.apidoc_current}/#by)
* [`formal`](#{site.urls.apidoc_current}/#formal)
* [`final`](#{site.urls.apidoc_current}/#final)
* [`late`](#{site.urls.apidoc_current}/#late)
* [`license`](#{site.urls.apidoc_current}/#license)
* [`native`](#{site.urls.apidoc_current}/#native)
* [`optional`](#{site.urls.apidoc_current}/#optional)
* [`see`](#{site.urls.apidoc_current}/#see)
* [`shared`](#{site.urls.apidoc_current}/#shared)
* [`throws`](#{site.urls.apidoc_current}/#throws)
* [`tagged`](#{site.urls.apidoc_current}/#tagged)
* [`variable`](#{site.urls.apidoc_current}/#variable)

## See also

* [Annotations](../../../tour/annotations) on the Tour of Ceylon
* [Keywords](../keyword)

