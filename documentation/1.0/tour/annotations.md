---
layout: tour
title: Tour of Ceylon&#58; Annotations and the metamodel
tab: documentation
unique_id: docspage
author: Gavin King
doc_root: ../..
---

# #{page.title}

Wow, part sixteen of the Tour of Ceylon and the end is in sight! The 
[last part](../initialization) covered initialization. This part is all 
about *annotations* and metaprogramming.


## Annotations

If you've made it this far into this series of articles, you've already seen 
lots of annotations. Annotations are *so* important in Ceylon that it's 
extremely difficult to write any code without using them. But we have not 
yet really explored what an annotation *is*.

Let's finally rectify that. The answer is simple: an annotation is a toplevel 
function that returns a subtype of 
[`ConstrainedAnnotation`](#{site.urls.apidoc_current}/metamodel/interface_ConstrainedAnnotation.html).
We call the function an _annotation constructor_.

## Annotation constructors

Here's the definition of a some of our old friends, `doc`:

<!-- try: -->
<!-- cat: shared class Deprecated(String? desc=null) {} -->
<!-- cat: shared class Description(String? desc=null) {} -->
<!-- cat: shared class Authors(String[] desc={}) {} -->
    "Annotation to specify API documentation of a program
     element." 
    shared annotation Doc doc(String description) => Doc(description);

And `by`:

<!-- try: -->
    "Annotation to specify API authors."
    shared annotation Authors by(String* authors) => Authors(*authors);

Of course, we can define our own annotations. (That's the whole point!)

<!-- try: -->
<!-- check:none:Annotations M5 -->
    shared annotation Scope scope(ScopeType s) => Scope(s);

Or:

<!-- try: -->
    shared annotation Todo todo(String text) => Todo(text);

Since annotation constructors are functions, annotation names always begin 
with a lowercase letter.


## Annotation arguments

When we specify an annotation with a non-empty parameter list on a program 
element, we need to specify arguments for the parameters of the annotation. 
Just like with a normal method invocation, we have the choice between a
positional argument list or a named argument list. We could write:

<!-- try-post:
    void test() { }
-->
    doc ("The Hello World program")
<!-- cat: void m() {} -->

Or:

<!-- try-post:
    void test() { }
-->
    doc { description="The Hello World program"; }
<!-- cat: void m() {} -->

Likewise, we could write:

<!-- try-post:
    void test() { }
-->
    by ("Gavin", "Stephane", "Emmanuel", "Tom", "Tako")
<!-- cat: void m() {} -->

Or:

<!-- try-post:
    void test() { }
-->
    by { "Gavin", "Stephane", "Emmanuel", "Tom", "Tako" }
<!-- cat: void m() {} -->

If an annotation has no arguments, we can just write the annotation name 
and leave it at that. We do this all the time with annotations like `shared`, 
`formal`, `default`, `actual`, `abstract`, `deprecated`, and `variable`.


## Annotation types

The return type of an annotation constructor is called the *annotation type*.
The `doc` annotation produces a `Doc`:

<!-- try: -->
    "The annotation class for the [[doc]] annotation."
    shared final annotation class Doc(shared String description)
            satisfies OptionalAnnotation<Doc, Annotated> {}

The `by` annotation produces `Authors`:

<!-- try: -->
    "The annotation class for [[by]]."
    shared final annotation class Authors(shared String* authors)
            satisfies OptionalAnnotation<Authors, Annotated> {}

Naturally, we can define our own annotation types:

<!-- try: -->
    shared final annotation class Todo(String text)
            satisfies SequencedAnnotation<Todo> {
        string => text;
    }

Or:

<!-- try: -->
    shared final annotation class Scope(shared ScopeType scope)
            satisfies OptionalAnnotation<Scope,ClassDeclaration> {
        string => (scope==request then "request")
             else (scope==session then "session")
             else (scope==application then "application")
             else nothing;
    }

Multiple annotation constructors may produce the same annotation type. An 
annotation type must be a subtype of `ConstrainedAnnotation`:

<!-- try: -->
<!-- check:none:Annotations M6 -->
    "An annotation. This interface encodes constraints upon 
     the annotation in its type arguments."
    shared interface ConstrainedAnnotation<out Value, out Values, 
                    in ProgramElement> 
            of Value
            satisfies Annotation<Value>
            given Value satisfies Annotation<Value>
            given ProgramElement satisfies Annotated {
        
        "Can this annotation can occur on the given program 
         element?"
        shared Boolean occurs(Annotated programElement) =>
                programElement is ProgramElement;
        
    }

The type arguments of this interface express constraints upon how annotations 
which return the annotation type occur. The first type parameter, `Value`, is 
simply the annotation type itself.


## Annotation constraints

The second type parameter, `Values`, governs how many different annotations 
of given program element may return the annotation type. Notice that
`ConstrainedAnnotation` has an `of` clause telling us that there are only 
two direct subtypes. So any annotation type must be a subtype of one of 
these two interfaces:

* If an annotation type is a subtype of 
  [`OptionalAnnotation`](#{site.urls.apidoc_current}/metamodel/interface_OptionalAnnotation.html), 
  at most one annotation of a given program element may be of this annotation type, or, 
  otherwise
* if an annotation type is a subtype of 
  [`SequencedAnnotation`](#{site.urls.apidoc_current}/metamodel/interface_SequencedAnnotation.html),
  more than one
  annotation of a given program element may be of this annotation type.

<!-- this comment is working around a bug in rdiscount -->

<!-- try: -->
<!-- check:none:Annotations M5 -->
    "An annotation that may occur at most once
     at a single program element."
    shared interface OptionalAnnotation<out Value, 
                    in ProgramElement=Annotated>
            of Value
            satisfies ConstrainedAnnotation<Value,Value?,ProgramElement>
            given Value satisfies Annotation<Value>
            given ProgramElement satisfies Annotated {}

    "An annotation that may occur multiple times
     at a single program element."
    shared interface SequencedAnnotation<out Value, 
                    in ProgramElement=Annotated>
            of Value
            satisfies ConstrainedAnnotation<Value,Value[],ProgramElement>
            given Value satisfies Annotation<Value>
            given ProgramElement satisfies Annotated {}

Finally, the third type parameter, `ProgramElement`, of `ConstrainedAnnotation`
constrains the kinds of program elements at which the annotation can occur. 
The argument to `ProgramElement` must be a metamodel type. So the argument 
`InterfaceDeclaration|AliasDeclaration` would constrain the annotation to occur 
only at interface and `alias` declarations. The argument `ValueDeclaration` would 
constrain the annotation to occur only value or attribute declarations.


## Restrictions on annotation parameters and annotation arguments

The specification defines a number of restrictions on annotation parameter
types:

> Each parameter of an annotation constructor [or initializer parameter of an 
> annotation type] must have one of the following types:
>
> - `Integer`, `Float`, `Character`, or `String`,
> - an enumerated type whose cases are all anonymous classes, such as `Boolean`,
> - a subtype of `Declaration` in `ceylon.language.model.declaration`,
> -  an annotation type,
> - `{T*}` or `[T*]` where `T` is a legal annotation constructor parameter type, 
>   or
> - any tuple type whose element types are legal annotation constructor parameter 
>   types.

Furthermore: 

- an annotation type can't contain initialization logic or reference declarations
  (it must have an empty initializer section), and 
- an annotation constructor can't contain multiple statements (it must simply 
  instantiate and return an annotation type).

Finally, an annotation argument may contain only:

- literal strings, characters, integers, and floats, 
- references to toplevel anonymous classes (for example, `true`), 
- program element reference expressions (for example, `` `interface List` ``, or 
  `` `function sum` ``), and
- iterable and tuple enumerations (`{ ... }` and `[ ... ]`) containing legal 
  annotation arguments.  

Some of these restrictions will likely be relaxed in future versions of the 
language.


## Reading annotation values at runtime

Annotation values may be obtained by calling the toplevel method 
[`annotations()`](#{site.urls.apidoc_current}/metamodel/#annotations) defined in the language module.

<!-- try: -->
<!-- check:none:Annotations M5 -->
    shared native Values annotations<Value,Values,ProgramElement>(
                  Class<ConstrainedAnnotation<Value,Values,ProgramElement>> 
                  annotationType,
                  ProgramElement programElement)
               given Value satisfies 
                       ConstrainedAnnotation<Value,Values,ProgramElement>
               given ProgramElement satisfies Annotated;

So to obtain the value of the `doc` annotation of the `Person` class, we 
write:

<!-- try: -->
<!-- check:none:Annotations M5 -->
    String? description = annotations(`Description`, 
                `class Person`)?.description;

Note that the expression `` `Description` `` returns the metamodel object 
for the type `Description`, an instance of `Class<Description,[]>`. The 
expression `` `class Person` `` returns the reference object for the program 
element `Person`, a `ClassDeclaration`.

To determine if the method `stop()` of a class named `Thread` is deprecated, 
we can write:

<!-- try: -->
<!-- check:none:Annotations M5 -->
    Boolean deprecated = exists annotations(`Deprecated`, 
                `function Thread.stop`);

Note that the expression `` `function Thread.stop` `` returns the reference 
object for the method `stop()` of `Thread`, an instance of `FunctionDeclaration`.

Here are two more examples, to make sure you get the idea:

<!-- try: -->
<!-- check:none:Annotations M5 -->
    Scope scope = annotations(`Scope`, `class Person`) else request;

<!-- try: -->
    Todo[] todos = annotations(`Todo`, `function method`);

Everything's set up so that `annotations()` returns `Scope?` for the 
optional annotation type `Scope`, and `Todo[]` for the sequenced annotation 
type `Todo`.

<!--
Of course, it's much more common to work with annotations in generic code, 
so you're more likely to be writing code like this:

    Entry<Attribute<Nothing,Object?>,String>[] attributeColumnNames(Class<Object> clazz) {
        return { for (att in clazz.members(Attribute<Nothing,Object?>))
                    att->columnName(att) };
    }

    String columnName(Attribute<Nothing,Object?> member) {
        return annotations(Column, member)?.name else member.name;
    }
As you can see, Ceylon annotations are framework-developer-heaven.
-->


## Defining annotations

We've seen plenty of examples of annotations built into Ceylon. Application 
developers don't often define their own annotations, but framework developers 
do this all the time. Let's see how we could define an annotation for 
declarative transaction management in Ceylon.

<!-- try: -->
<!-- check:none:Annotations M5 -->
    shared annotation Transactional transactional
            (Boolean requiresNew = false)
        => Transactional(requiresNew);

This method simply produces an instance of the class `Transactional` that 
will be attached to the metamodel of an annotated method or attribute. 
The meta-annotation specifies that the annotation may be applied to methods 
and attributes, and may occur at most once on any member.

<!-- try: -->
<!-- check:none:Annotations M5 -->
    shared final annotation class Transactional(requiresNew)
            satisfies OptionalAnnotation<Transactional,
                            FunctionDeclaration|ValueDeclaration> {
        shared Boolean requiresNew;
    }

Now we can apply our annotation to a method of any class.

<!-- try: -->
<!-- check:none:Annotations M5 -->
    shared class OrderManager() {
        shared transactional void createOrder(Order order) { ... }
        ...
    }

We could specify an explicit argument to the parameter of transactional using 
a positional argument list:

<!-- try: -->
<!-- check:none:Annotations M5 -->
    shared transactional (true)
    void createOrder(Order order) { ... }

Alternatively, we could use a named argument list:

<!-- try: -->
<!-- check:none:Annotations M5 -->
    shared transactional { requiresNew=true; }
    void createOrder(Order order) { ... }

We won't need to use reflection in our example, since Ceylon's module 
architecture includes special built-in support for using annotations to add
interceptors to methods and attributes.

## The metamodel

TODO!

## There's more ...

Well actually, we've finished the tour! Of course, there's still plenty of 
scope for you to explore Ceylon on your own. You should now know enough to 
start writing Ceylon code for yourself, and start getting to know the platform 
modules.

Alternatively, if you want to keep reading you can browse the 
[reference documentation](#{page.doc_root}/reference) or (if you're sitting 
comfortably) read the [specification](#{page.doc_root}/#{site.urls.spec_relative}).
