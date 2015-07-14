---
layout: reference12
title_md: Class Declarations
tab: documentation
unique_id: docspage
author: Tom Bentley
doc_root: ../../..
---

# #{page.title_md}

A class is a stateful [type declaration](../type-declaration) that:

- may hold references to other objects,
- may define initialization logic, and
- except in the case of an `abstract` or `formal` class, may be instantiated.

A class may inherit another class, but classes are restricted to a
_single inheritance_ model. That is, a class inherits exactly _one_
other class. Since single inheritance is quite often too restrictive,
a class may also satisfy an arbitrary number of [interfaces](../interface).

## Usage 

A trivial class declaration looks like this:

<!-- id:c -->
<!-- try: -->
    class Trivial() {
        /* declarations of class members */
    }

A more general form of a class declaration with initializer parameters 
looks like this:

<!-- lang:none -->
    ANNOTATIONS
    class Example
            <TYPE-PARAMETERS>
            (INITIALIZER-PARAMETERS) 
            of ENUMERATED-SUBCLASSES
            extends SUPER-CLASS-INVOCATION
            satisfies SUPER-INTERFACES
            given TYPE-PARAMETER-CONSTRAINTS {
        CLASS-BODY
    }

Where:

* `ANNOTATIONS` is a list of class [annotations](../annotation)
* `TYPE-PARAMETERS` is a `,`-separated list of [type parameters](../#type_parameters)
* `INITIALIZER-PARAMETERS` is a `,`-separated list of [value parameters](../parameters-list)
* `ENUMERATED-SUBCLASSES` is a `|`-separated list of [class types](#enumerated_classes)
* `SUPER-CLASS-INVOCATION` is [class invocation expression](#extending_classes) for the superclass initializer
* `SUPER-INTERFACES` is a `&`-separated list of [interface type expressions](#satisfying_interfaces)
* `TYPE-PARAMETER-CONSTRAINTS` is a list of [constraints on type parameters](../type-parameters#constraints) 
  declared in the type parameter list
* `CLASS-BODY` is the [initializer section](#initializer) of the class, 
  followed by the [declaration section](#declaration_section) of the class

An alternative to declaring a class with initializer parameters is to 
provide one or more constructors.

<!-- lang:none -->
    ANNOTATIONS
    class Example
            <TYPE-PARAMETERS>
            /* no parameter list */
            of ENUMERATED-SUBCLASSES
            extends SUPER-CLASS
            satisfies SUPER-INTERFACES
            given TYPE-PARAMETER-CONSTRAINTS {
        INITIALIZER-STATEMENTS-AND-CONSTRUCTORS
        DECLARATIONS
    }
    
Where:

* `SUPER-CLASS` is the type expression for the superclass (not an invocation)
* `INITIALIZER-STATEMENTS-AND-CONSTRUCTORS` consists of statements in the intializer and constructor declarations
* `DECLARATIONS` constitute the [declaration section](#declaration_section) 
  of the class.

## Description

### Type parameters

A class declaration may have a list of [type parameters](../type-parameters) 
enclosed in angle brackets (`<` and `>`) after the class name:

<!-- try: -->
    class Generic<Foo, Bar>() {
        /* declarations of class members 
           type parameters Foo and Bar are treated as a types */
    }
    
A class with type parameters is sometimes called a *generic class*.

A class declaration with type parameters may also have a `given` clause 
for each declared type parameter to 
[constrain the argument types](../type-parameters#constraints):

    class Constrained<Foo, Bar>() 
            given Foo satisfies Baz1&Baz2
            given Bar of Gee1|Gee2 {
        /* declarations of class members 
           type parameters Foo and Bar treated as a types */
    }

### Initializer parameters

Class declarations *usually* have a [parameter list](../parameter-list), the *initializer parameters*,

    class WithParameters(Integer param1, String param2) {
        // ...
    }

The initializer parameters are visible to statements in 
the [class initializer](#initializer).

If a class lacks a parameter list it must have one or more 
[constructor declarations](#constructor_declarations). 

#### Callable type

A class may be viewed as a function that produces new instances of
the class. The *callable type* of a class expresses, in terms of 
the interface [`Callable`](#{site.urls.apidoc_1_2}/Callable.type.html), 
the type of this function.

For example the callable type of 

<!-- try: -->
    class CallableExample(Integer int, Boolean bool) => "";
    
is `CallableExample(Integer, Boolean)`, because the class initializer takes 
`Integer` and `Boolean` parameters and invoking the class results in a 
`CallableExample` instance being returned to the caller.

(Regular functions also have a [callable type](../function/#callable_type).)

### Extending classes

The `extends` clause is used to:

* specify that the class being declared is a 
  [subtype](../type-declaration#declarative_subtyping) 
  of the given class type and,
* [invoke](../expression/invocation/) that class's initializer.

In the case of a class with initializer parameters the superclass constructor
is invoked directly in the class's `extends` clause:

<!-- cat-id:c -->
<!-- try: -->
    class S() extends C() {
        /* declarations of class members */
    }
    
In the case of a class with constructors each constructor declaration has its 
own `extends` clause for invoking the appropriate superclass constructor:

    class T extends C {
        shared new () extends C() {}
        new nonShared() extends C.nonShared() {}
    }

If a class is declared without using the `extends` keywords, it is a 
subclass of [`Basic`](#{site.urls.apidoc_1_2}/Basic.type.html).

### Satisfying interfaces

The `satisfies` clause is used to specify that the class being declared is a
[subtype](../type-declaration#declarative_subtyping) 
of the given interface type.

<!-- cat: interface I1 {} interface I2 {} -->
<!-- try: -->
    class C() satisfies I1 & I2 {
        /* declarations of class members */
    }

`&` is used as the separator between satisfied interface types 
because the class (`C`) is being declared as a subtype of an 
[intersection type](../type#union_and_intersection) (`I1&I2`).

If a class is declared without using the `satisfies` keyword, it does
not _directly_ inherit any interfaces. However, it may indirectly 
inherit interfaces via its superclass.

### Enumerated classes

The subclasses of an `abstract` class can be constrained to a list of 
named class types (including toplevel anonymous classes) using the `of` clause. 
If the class `C` is permitted only two direct subclasses, `S1` and `S2`, 
its declaration would look like this:

<!-- try: -->
    abstract class C() of S1 | S2 {
        /* declarations of class members */
    }

The subclasses have to `extend` `C`:

    class S1() extends C() {
    }
    class S"() extends C() {
    }

Then `S1` and `S2` are called the *cases* of `C`.

If a class has enumerated subclasses we can use the subclasses as
`is` cases in a 
[`switch` statement](../../statement/switch#caseis_assignability_condition).

### Initializer

The class *initializer* executes when instances of the class are created
(also known as *class instantiation*). 
The parameters to the initializer (if any) are specified in parenthesis 
after the name of the class in the `class` declaration.

The body of a class must *definitely initialize* every member of the class. 
The following code will be rejected by the compiler because if `bool` 
is false `greeting` does not get initialized:

    class C(Boolean bool) {
        shared String greeting;
        if (bool) {
            greeting = "hello";
        }
    }

The typechecker figures out for itself the point in the class at which all 
class members have been initialized. Everything before this point is in 
the *initializer section* of the class, and everything after this point 
is in the *declaration section*. In the initializer section you 
can't use a declaration before it's been declared.

Note that `abstract` classes cannot be invoked directly, but 
they are still invoked in the `extends` clause of their subclasses.

### Constructor Declarations

If a class lacks [initializer parameters](#initializer_parameters) 
it must have one or more *constructor declarations*. 

**Note:** Constructors allow sophistocated initialization logic, 
but at a cost in terms of complexity and verbosity compared with 
classes with initializer parameters. It is recommended to 
prefer classes with initializer parameters where possible. 
Most classes can be written with initializer parameters.

The job of the constructor is to particpate in initialzing a 
class instance. A constructor is either be a *value constructor* or 
a *callable constructor*. 

#### Value Constructors

A value constructor is simply a named instance of a class that it accessible by name, without requiring a parameter list:

    class ValueConstructor {
        new example {
            // initialization logic
        }
    }
    
The instance is created lazily on first access 
(i.e. when `ValueConstructor.example` is first evaluated) 
and is initialized according to the body of the 
value constructor `example`. 
Thereafter further references to `example` refer to the 
*same instance*. This can be viewed as a form of the 
singleton pattern, rather like an [`object` declaration](../object/). 
Unlike an `object` declaration, however, a value constructor is not 
declaring a new class, simply a named instance of a class with 
some initialization logic.

It is possible to constrain the class to have a finite set 
of named instances using the `of` clause:

    class EnumeratedInstances 
            of one|two|more {
        new one {
        }
        new two {
        }
        new more {
        }       
    }


#### Callable Constructors

A callable constructor is function that participates in 
initializing an instance of the class. 

    class CallableConstructor {
        new example() {
            // initialization logic
        }
    }
    
A callable constructor always initializes a fresh instance of 
the class, and multiple invocations of a callable constructor 
result in multiple instances of the class.

#### Default Constructors

The callable constructor with no name is the *default constructor*

    class DefaultConstructor {
        shared new () {
        }
    }
    
This is the constructor used when the class is instantiated 
without an explicit constructor, for example via the invocation
`DefaultConstructor()`.

This has an important consequence with respect to refactoring: 
A class with a parameter list can be refactored into a class 
with a default constructor without affecting the sites where 
the class was instantiated.

Classes do not need to have a default constructor, but if it exists it must be `shared`.

#### Constructor Delegation

When a class has constructors the class's `extends` clause is the expression for the superclass type, and not an invocation expression. Delegation to the superclass for initialization is instead achieved via an `extends` clause on the *constructor declaration*:

    class DelegationToDefault extends DefaultConstructor {
        shared new () extends DefaultConstructor() {
        }
    }
    class DelegationToNamed extends CallableConstructor {
        shared new () extends CallableConstructor.example() {
        }
    }

Alternatively the constructor can delegate to another 
constructor of the *same* class:

    class SelfDelegation {
        shared greet(String greeting, String subject) {
        }
        shared new hello(String subject) extends greet("hello", subject) {
        }
        shared new helloWorld extends hello("world") {
        }
    }

The above example shows a callable constructor `hello` delegating to a callable constructor `greet`, and a value constructor `helloWorld` delegating to `hello`.

#### `abstract` Constructors

A callable constructor usually has to initialize all the 
members of the class which are not initialized by 
the rest of the initializer section of the class.

An `abstract` constructor is allowed to leave members unitialized. An `abstract` constructor can only be used for other constructors to delegate to (otherwise you could obtain a partially initialized instance, which would defeat the whole point of having constructors). It follows that `abstract` constructors may not be `shared`.

#### Statements between constructors

Constructors occur in the initializer section of the class, but they can be preceeded by, separated by and followed by other statements, which are executed in order during initialization:

    class StatementsAndConstructors {
        print(1);
        abstract foo() {
            print(2);
        }
        print(3)
        shared new () extends foo() {
            print(4);
        }
        print(5);
    }

An invocation such as `StatementsAndConstructors()` would 
have the side-effect of printing 

    1
    2
    3
    4
    5

to standard output.

### Declaration section

#### Members

The permitted members of classes are [classes](../class), 
[interfaces](../interface), [methods](../function), [attributes](../value),
and [`object`s](../object).

#### Member class refinement

An inner class of a class or interface can be subject to 
*member class refinement*, which means its instantiation will be 
polymorphic. 

Here's an example where a `Reader` class declares that concrete 
subclasses *must* (because we used `formal`) provide an `actual Buffer` 
inner class.

<!-- try: -->
    shared abstract class Reader() {
        shared formal class Buffer(Character* chars)
                satisfies Sequence<Character> {}
        // ...
    }

    shared class FileReader(File file) 
            extends Reader() {
        shared actual class Buffer(Character* chars)
                extends super.Buffer(*chars) {
            // ...
        }
        // ...
    }

Within `Reader` (and elsewhere) we can instantiate the relevant kind of 
`Buffer` with a normal instantiation, `Buffer(chars)`. This allows each 
subclass of `Reader` to implement an appropriate kind of `Buffer`.

Member class refinement is a lot like the 'abstract factory' pattern in
other object-oriented languages, but it's a lot less verbose.

Only `formal` and `default` member classes are subject to member class 
refinement. A `formal` member class *must* be refined by concrete subtypes 
of the type declaring the member class—just like a `formal` method 
or attribute. A `default` member class *may* be refined—just like
a `default` method or attribute.

In a subtype of the type declaring the member class, the member class 
(i.e. in `FileReader.Buffer` from the example above) must:

* be declared `actual`,
* have the same name as the member class in the declaring type (`Buffer` 
  in the example),
* have a parameter list with a compatible signature and,
* extend the member class (you'll need to use 
  [`super`](../../expression/index.html#supertype_reference)
  in the `extends` clause).

Refined member types are similar to, but not the same as, _virtual types_, 
which Ceylon does not support.

### Different kinds of class

#### Concrete classes

A class that can be instantiated is 
*concrete*. It follows that `abstract` or `formal` classes are not concrete.

#### Abstract classes

An _abstract class_ is a class that may not be instantiated. Abstract classes
may declare [`formal`](../../annotation/formal) members. An abstract class 
declaration must be annotated [`abstract`](../../annotation/abstract):

<!-- try: -->
    abstract class C() {
        /* declarations of class members */
    }

Naturally, abstract classes compete with interfaces, since both an abstract 
class and an interface may contain a mix of concrete and formal members. The
crucial difference is:

- an abstract class may contain or inherit state and initialization logic, 
  whereas
- interfaces support a full multiple inheritance model.

Nevertheless, it is often unclear whether a certain situation calls for an
interface or an abstract class. Our advice is to incline in favor of using
an interface, where reasonable.

#### `shared` classes

A toplevel class declaration, or a class declaration nested inside the body 
of a containing class or interface, may be annotated 
[`shared`](../../annotation/shared):

<!-- try: -->
    shared class C() {
        /* declarations of class members */
    }

- A toplevel `shared` class is visible wherever the package that contains it 
  is visible.
- A `shared` class nested inside a class or interface is visible wherever the 
  containing class or interface is visible.

#### `formal` classes

A class declaration nested inside the body of a containing class or interface
may be annotated [`formal`](../../annotation/formal). A formal class must 
also be annotated `shared`.

Like abstract classes, formal classes may have formal members. Unlike abstract
classes, formal classes may be instantiated.

A `formal` class must be [refined](#member_class_refinement) by concrete 
subclasses of the containing class or interface. 

#### `default` classes

A class declaration nested inside the body of a containing class or interface
may be annotated [`default`](../../annotation/default). A default class must 
also be annotated `shared`.

A `default` class may be [refined](#member_class_refinement) by types which
inherit the containing class or interface. 

#### `sealed` classes

A class declaration annotated `sealed` cannot be instantiated (either 
in an invocation expression or in an extends clause) outside the module 
in which it is defined. This provides a way to share a 
class's type with other modules while retaining control over subclassing 
and instance creation.

### Aliases

A *class alias* is a kind of [alias](../alias/#class_aliases).

### Metamodel

Class declarations can be manipulated at runtime via their representation as
[`ClassDeclaration`](#{site.urls.apidoc_1_2}/meta/declaration/ClassDeclaration.type.html) 
instances. An *applied class* (i.e. with all type parameters specified) 
corresponds to either a 
[`Class`](#{site.urls.apidoc_1_2}/meta/model/Class.type.html) or 
[`MemberClass`](#{site.urls.apidoc_1_2}/meta/model/MemberClass.type.html) 
model instance.

## See also

* [Interface declarations](../interface/)
* [Classes](#{site.urls.spec_current}#classes) in the Ceylon language spec
