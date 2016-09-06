---
layout: tour13
title: Annotations and the metamodel
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

If you've made it this far into this series of articles, you've already 
seen lots of annotations. Annotations are *so* important in Ceylon that 
it's extremely difficult to write any code without using them. But we 
have not yet really explored what an annotation actually *is*.

Let's finally rectify that. The answer is simple: an annotation is a 
toplevel function that returns a subtype of 
[`ConstrainedAnnotation`](#{site.urls.apidoc_1_3}/ConstrainedAnnotation.type.html).
We call the function an _annotation constructor_.

## Annotation constructors

Here's the definition of a some of our old friends, first `shared`:

<!-- try: -->
    "Annotation to mark a type or member as shared. A `shared` 
     member is visible outside the block of code in which it is 
     declared."
    shared annotation SharedAnnotation shared() 
            => SharedAnnotation();

Then `doc`:

<!-- try: -->
    "Annotation to specify API documentation of a program
     element." 
    shared annotation DocAnnotation doc(String description)
            => DocAnnotation(description);

And `by`:

<!-- try: -->
    "Annotation to specify API authors."
    shared annotation AuthorsAnnotation by(String* authors) 
            => AuthorsAnnotation(*authors);

Of course, we can define our own annotations. (That's the whole point!)

<!-- try: -->
<!-- check:none:Annotations M5 -->
    shared annotation ScopeAnnotation scope(Scope s) => ScopeAnnotation(s);

Or:

<!-- try: -->
    shared annotation TodoAnnotation todo(String text) => TodoAnnotation(text);

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
    doc { description = "The Hello World program"; }
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
    by { authors = ["Gavin", "Stephane", "Emmanuel", "Tom", "Tako"]; }
<!-- cat: void m() {} -->

If an annotation has no arguments, we can just write the annotation name 
and leave it at that. We do this all the time with annotations like `shared`, 
`formal`, `default`, `actual`, `abstract`, `deprecated`, and `variable`.


## Annotation types

The return type of an annotation constructor is called the *annotation type*.
The `shared` annotation produces a `SharedAnnotation`:

<!-- try: -->
    "The annotation class for [[shared]]."
    shared final annotation class SharedAnnotation()
            satisfies OptionalAnnotation<SharedAnnotation, 
                FunctionOrValueDeclaration|ClassOrInterfaceDeclaration|
                        Package|Import> {}

The `doc` annotation produces a `DocAnnotation`:

<!-- try: -->
    "The annotation class for the [[doc]] annotation."
    shared final annotation class DocAnnotation(shared String description)
            satisfies OptionalAnnotation<DocAnnotation, Annotated> {}

The `by` annotation produces `AuthorsAnnotation`:

<!-- try: -->
    "The annotation class for [[by]]."
    shared final annotation class AuthorsAnnotation(shared String* authors)
            satisfies OptionalAnnotation<AuthorsAnnotation, Annotated> {}

Naturally, we can define our own annotation types:

<!-- try: -->
    shared final annotation class TodoAnnotation(String text)
            satisfies SequencedAnnotation<TodoAnnotation> {
        string => text;
    }

Or:

<!-- try: -->
    shared final annotation class ScopeAnnotation(shared Scope scope)
            satisfies OptionalAnnotation<ScopeAnnotation, ClassDeclaration> {
        string => (scope==request then "request")
             else (scope==session then "session")
             else (scope==application then "application")
             else nothing;
    }

Multiple annotation constructors may produce the same annotation type. An 
annotation type must be a subtype of `ConstrainedAnnotation`:

<!-- try: -->
<!-- check:none:Annotations M6 -->
    "An annotation constrained to appear only on certain 
     program elements, and only with certain values..."
    shared interface ConstrainedAnnotation<out Value=Annotation, 
                                           out Values=Anything, 
                                           in ProgramElement=Nothing> 
            of Value
            satisfies Annotation<Value>
            given Value satisfies Annotation<Value>
            given ProgramElement satisfies Annotated {
        
        "Can this annotation occur on the given program 
         element?"
        shared Boolean occurs(Annotated programElement)
                => programElement is ProgramElement;
        
    }

The type arguments of this interface express constraints upon how annotations 
which return the annotation type occur. The first type parameter, `Value`, is 
simply the annotation type itself.


## Annotation constraints

The second type parameter, `Values`, governs how many different annotations 
of given program element may return the annotation type. Ceylon provides two 
subtypes of `ConstrainedAnnotation` that will be useful for the most common 
cases:

* If an annotation type is a subtype of 
  [`OptionalAnnotation`](#{site.urls.apidoc_1_3}/OptionalAnnotation.type.html), 
  at most one annotation of a given program element may be of this annotation 
  type, or, otherwise
* if an annotation type is a subtype of 
  [`SequencedAnnotation`](#{site.urls.apidoc_1_3}/SequencedAnnotation.type.html),
  more than one annotation of a given program element may be of this annotation 
  type.

Where `OptionalAnnotation` is defined in the language module:

<!-- try: -->
<!-- check:none:Annotations M5 -->
    "An annotation that may occur at most once at a given 
     program element..."
    shared interface OptionalAnnotation<out Value, 
                    in ProgramElement=Annotated>
            of Value
            satisfies ConstrainedAnnotation<Value,Value?,ProgramElement>
            given Value satisfies Annotation<Value>
            given ProgramElement satisfies Annotated {}

Along with `SequencedAnnotation`:

<!-- try: -->
<!-- check:none:Annotations M5 -->
    "An annotation that may occur multiple times at a given 
     program element..."
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
constrain the annotation to occur only at value or attribute declarations.


## Restrictions on annotation parameters and annotation arguments

The specification defines a number of restrictions on annotation parameter
types:

> Each parameter of an annotation constructor [or initializer parameter of an 
> annotation type] must have one of the following types:
>
> - `Integer`, `Float`, `Character`, or `String`,
> - an enumerated type whose cases are all anonymous classes, such as `Boolean`,
> - a subtype of `Declaration` in `ceylon.language.meta.declaration`,
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
- program element reference expressions (for example, `` `interface List` ``, 
  or `` `function sum` ``), and
- iterable and tuple enumerations (`{ ... }` and `[ ... ]`) containing legal 
  annotation arguments.  

Some of these restrictions will likely be relaxed in future versions of the 
language.


## Reading annotation values at runtime

Annotation values may be obtained by calling the toplevel method 
[`annotations()`](#{site.urls.apidoc_1_3}/meta/index.html#annotations) 
defined in the language module.

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
    String? description = annotations(`DocAnnotation`, 
                `class Person`)?.description;

Note that the expression `` `DocAnnotation` `` returns the metamodel object 
for the type `DocAnnotation`, an instance of `Class<DocAnnotation,[String]>`. 
The expression `` `class Person` `` returns the reference object for the 
program element `Person`, a `ClassDeclaration`.

To determine if the method `stop()` of a class named `Thread` is deprecated, 
we can write:

<!-- try: -->
<!-- check:none:Annotations M5 -->
    Boolean deprecated = annotations(`DeprecationAnnotation`, 
                `function Thread.stop`) exists;

Note that the expression `` `function Thread.stop` `` returns the reference 
object for the method `stop()` of `Thread`, an instance of `FunctionDeclaration`.

Here are two more examples, to make sure you get the idea:

<!-- try: -->
<!-- check:none:Annotations M5 -->
    Scope scope = annotations(`ScopeAnnotation`, `class Person`)?.scope else request;

<!-- try: -->
    String[] todos = annotations(`TodoAnnotation`, `function method`)*.text;

Everything's set up so that `annotations()` returns `ScopeAnnotation?` for the 
optional annotation type `ScopeAnnotation`, and `TodoAnnotation[]` for the 
sequenced annotation type `TodoAnnotation`.

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
    shared annotation TransactionalAnnotation transactional
            (Boolean requiresNew = false)
        => TransactionalAnnotation(requiresNew);

This method simply produces an instance of the class `TransactionalAnnotation` 
that will be attached to the metamodel of an annotated method or attribute. 
The meta-annotation specifies that the annotation may be applied to methods 
and attributes, and may occur at most once on any member.

<!-- try: -->
<!-- check:none:Annotations M5 -->
    shared final annotation class TransactionalAnnotation(requiresNew)
            satisfies OptionalAnnotation<TransactionalAnnotation,
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
    shared transactional { requiresNew = true; }
    void createOrder(Order order) { ... }

<!--We won't need to use reflection in our example, since Ceylon's module 
architecture includes special built-in support for using annotations to add
interceptors to methods and attributes.-->

## The metamodel

The Ceylon metamodel is an API that allows a program to interact with its
own program elements and the types they define at runtime. This capability
is commonly called _reflection_ or _introspection_ in other languages.
Reflection makes possible _runtime metaprogramming_.

_Note: Ceylon does not support any form of compile-time metaprogramming._

In fact, the Ceylon metamodel is divided into two separate APIs:

- `ceylon.language.meta.declaration` defines a _detyped_ model of 
  declarations, packages, and modules, while 
- `ceylon.language.meta.model` defines a statically typed model of types
  and typed declarations.

The language provides a built-in syntax for obtaining the metamodel for
a program element. All metamodel expressions are enclosed in backticks.

A program element reference expression specifies the fully-qualified name 
of the program element, and a keyword indicating the kind of program 
element it is. We've already seen a few examples of this syntax in `see` 
and `throws` annotations:

<!-- try: -->
    `class Singleton`
    `interface List`
    `function Iterable.map`
    `function sum`
    `alias Number`
    `value Iterable.size`
    `given Element`
    `module ceylon.language`
    `package ceylon.language.meta`

Reference expressions produce an instance of a subtype of `Declaration`,
for example, a reference to a `class` is of type `ClassDeclaration`, and
a reference to a `function` is of type `FunctionDeclaration`. They're
especially useful for defining cross-references between program elements
in annotations.

A typed metamodel expression specifies a type or fully-typed function or
value. No keyword is necessary. By "fully-typed", I mean that type 
arguments must be provided to all type parameters of a generic type or 
function. For example:

<!-- try: -->
    `Singleton<String>`
    `List<Float|Integer>`
    `{Object+}`
    `{Anything*}.map<String>`
    `sum<Float>`
    `{String*}.size`
    `[Float,Float,String]`
    `Float|Integer`
    `Element`

A typed metamodel expression evaluates to a metamodel object whose static
type captures the type of the referenced program element. For example:

- `Singleton<String>` is of type `Class<Singleton<String>,[String]>`,
- `{Anything*}.map<String>` is of type 
  `Method<{Anything*},{String*},[String(Anything)]>`, and
- `Float|Integer` is of type `UnionType<Float|Integer>`.

Thus, we can interact with our program at the meta level without losing
the benefits of static typing. For example, I can write a generic function
like the following:

<!-- try: -->
    T createTriple<T,E>(Class<T,[E,E,E]> c, Function<E,[Integer]> e)
            => c(e(0),e(1),e(2)); 

And use it like this:

<!-- try: -->
    Integer isqr(Integer i) => i*i;
    class Triple<T>(T t0, T t1, T t2) {}
    
    Triple<Integer> triple = createTriple(`Triple<Integer>`, `isqr`)

OK, sure, that's a very contrived example, and doesn't demonstrate
anything that we couldn't do more efficiently with function references.
Runtime metaprogramming is primarily intended to ease the development of
frameworks and libraries for Ceylon, and therefore further discussion of
the topic is outside of the scope of this tour.


## There's more ...

You can learn more about the metamodel from its 
[API documentation](#{site.urls.apidoc_1_3}/meta/index.html).

The last two chapters of this tour deal with interoperation with other
languages, first with [Java](../interop), and then with dynamically
typed [JavaScript](../dynamic).
