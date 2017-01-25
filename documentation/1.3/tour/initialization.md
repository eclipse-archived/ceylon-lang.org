---
layout: tour13
title: Initialization and constructors
tab: documentation
unique_id: docspage
author: Gavin King
doc_root: ../..
---

# #{page.title}

This is the fifteenth part of the Tour of Ceylon. In the 
[last part](../language-module) we learned about the language module, 
[`ceylon.language`](#{site.urls.apidoc_1_3}/index.html). Now we're going to 
get into the details of *initialization*, and the restrictions that Ceylon 
places upon your code to ensure that you never experience anything like 
Java's infamous `NullPointerException`.

But first, we need to learn a little more about references to the current
object.

## Self references and outer instance references

When a method of a class is invoked upon an instance of the class, the body 
if the method is executed with an implicit reference to the instance. This
reference is called the _current instance_ of the class. Usually, we can
refer to any other member of the current instance without needing to 
explicitly specify the current instance.

    class Greeting(String name) {
        shared void greet()
            => print("Hello ``name``!"); //implicitly refers to this.name
    } 

However, it's possible for a name collision to hide a member of the class.

    class Greeting(String name) {
        shared void greet(String name) {
            print("``name`` says 'Hello ``name``!'"); //oops, local name hides this.name!
        }
    } 

We can resolve the name collision using the keyword `this`.

    class Greeting(String name) {
        shared void greet(String name) {
            print("``name`` says 'Hello ``this.name``!'"); //oops, local name hides this.name!
        }
    } 

### Self references

Ceylon features the keywords `this` and `super`, which refer to:

- the instance that is being initialized, within the initializer of the 
  class, or to
- the current instance of a class, within the body of any operation
  (method invocation, member class instantiation, or attribute 
  evaluation/assignment) of the class.

The difference between `this` and `super` is that `super` bypasses any
`actual` operation defined in the current class, and directly calls the
operation it refines.

The semantics are exactly the same as what you're used to in Java, with 
one exception: a reference to a member of `super` might refer to a member 
inherited from an interface, instead of from a superclass. 

### Tip: disambiguating `super` references

Consider this class:

<!-- try: -->
    class Impl() extends Class() satisfies Interface { ... }

Inside the body of this class, the expression `super` is treated as having 
the type `Class & Interface`. But what if `Class` and `Interface` both 
descend from a common ancestor with a method named `ambiguous()`, and `Impl` 
inherits two different implementations of `ambiguous()`, one from `Class`, 
and one from `Interface`? Then the expression `super.ambiguous()` would be, 
well, super-ambiguous.

In this case, the [widening operator][of] `of` may be used to disambiguate 
the member reference:

<!-- try: -->
    (super of Interface).ambiguous() //ambiguity resolved!

Here, the `of` operator is used to widen the type of the expression `super`
from `Class & Interface` to just `Interface`, thus resolving the ambiguity
as to which `ambiguous()` method is being called.

[of]: /documentation/reference/operator/of/

### Outer instance references

In addition to `this` and `super`, Ceylon features the keyword `outer`, which 
refers to the parent instance of the current instance of a nested class.

<!-- try:post
    print(Parent("outer").Child("inner").qualifiedName);
-->
    class Parent(name) {
        shared String name;
        shared class Child(name) {
            shared String name;
            shared String qualifiedName = 
                    outer.name + "/" + name;
            shared Parent parent => outer;
        }
    }

There are some restrictions on the use of `this`, `super`, and `outer`, which 
we'll explore below.

### Containing package references

Finally, the keyword `package` may be used to refer to the toplevel declarations
in the current package.

<!-- try: -->
    String name = "Trompon";
    
    class Elephant(name = package.name) {
        String name;
    }

## Multiple inheritance and "linearization"

Ceylon features a restricted kind of multiple inheritance often called 
_mixin inheritance_. Some languages with multiple inheritance or even mixin 
inheritance feature so-called "depth-first" member resolution or 
linearization where all supertypes of a class are arranged into a linear 
order. We believe that this model is unacceptably arbitrary and fragile.

Ceylon doesn't perform any kind of linearization of supertypes. The order in 
which types appear in the `satisfies` clause is never significant. The only 
way one supertype can take "precedence" over another supertype is if the 
first supertype is a subtype of the second supertype. The only way a member 
of one supertype can take precedence over a member of another supertype is if 
the first member refines the second member.

In our view, there's no non-fragile basis for deciding that one type 
specializes another type unless the first type is explicitly defined to be a 
subtype of the second. There's no non-fragile basis for deciding that one 
operation is more specific than another operation unless the first operation 
is explicitly declared to refine the second.

For a similar reason, interfaces shouldn't be able to define initialization 
logic. There's no non-fragile way to define the ordering in which supertype 
initializers are executed in a multiple-inheritance model. This is the basic 
reason why [interfaces are stateless](../inheritance#interfaces_and_mixin_inheritance) 
in Ceylon.

<!--
(Note that these arguments are even stronger in the case of 
[adapter introduction](../introduction), where linearization or statefulness 
would be even more fragile.)
-->

So Ceylon is more restrictive than some other languages in this respect. But 
we think that this restriction makes a subtype less vulnerable to breakage due 
to changes in its supertypes.


## Definite assignment and definite initialization

A really nice feature of Java is that the compiler checks that a local 
variable has definitely been assigned a value before allowing use of the 
local variable in an expression. So, for example, the following code compiles 
without error:

<!-- try-pre:
    value person = "Someone";
    value me = "Me";

-->
<!-- cat: void m(String person, String me) { -->
    String greeting;
    if (person == me) {
        greeting = "You're beautiful!";
    }
    else {
        greeting = "You're ugly!";
    }
    print(greeting);
<!-- cat: } -->

But the following code results in an error at compile time:

<!-- try-pre:
    value person = "Someone";
    value me = "Me";

-->
<!-- check:none:demos error -->
    String greeting;
    if (person == me) {
        greeting = "You're beautiful!";
    }
    print(greeting);   //error: greeting not definitely initialized

Many (most?) languages don't perform this kind of static analysis, which 
means that use of an uninitialized variable results in an error at runtime 
instead of compile time.

Unfortunately, Java doesn't do this same kind of static analysis for instance 
variables, not even for `final` instance variables. Instead, an instance 
variable which is not assigned a value in the constructor is initialized to a 
default value (zero or `null`). Surprisingly, it's even possible to see this 
default value for a `final` instance variable that is eventually assigned a 
value by the constructor. Consider the following code:

<!-- lang: java -->
    //Java code that prints "null"
    class Broken {
        final String greeting;
         
        Broken() {
            print();
            greeting = "Hello";
        }
     
        void print() {
            System.out.println(greeting);
        }
     
    }
    new Broken();

This behavior is bad enough in and of itself. But it would be even less 
acceptable in Ceylon, where most types don't have an acceptable "default" 
value. For example, consider the type `Person`. What would be an acceptable 
default value of this type? The value `null` certainly won't do, since it's 
not even an instance of `Person`. (It's an instance of `Null`, 
[remember!](../basics#dealing_with_objects_that_arent_there)) Sure, 
evaluation of an uninitialized instance variable could be defined 
to result in an immediate exception, that would just be our old friend 
`NullPointerException` creeping back in by the back door. 

Indeed, very few object-oriented languages perform the necessary static 
analysis to ensure definite initialization of instance variables, and this 
is perhaps one of the main reasons why object-oriented languages have never 
featured typesafe handling of `null` values.


### Class bodies

In order to make it possible for the compiler to guarantee definite 
initialization of attributes, Ceylon imposes some restrictions on the body 
of a class.

Actually, to be completely fair, they're not strictly speaking _restrictions_ 
at all, at least not from a ceylonic point of view, since you're actually 
allowed *extra* flexibility in the body of a class that you're not allowed in 
the body of a function or getter declaration! But, at least compared to Java, 
there's some things you're not allowed to do.

First, we need to know that the compiler automatically divides the body of 
the class into two sections:

* First comes the *initializer* section, which contains a mix of declarations, 
statements and control structures. The initializer is executed every time the 
class is instantiated.
* Then comes the *declaration* section, which consists purely of declarations, 
similar to the body of an interface.

Now we're going to introduce some rules that apply to code that appears in 
each section. The purpose of these rules is to guarantee that an instance 
variable has had a value specified or assigned before its value is used in 
an expression.

But you don't need to actually explicitly think about these rules when you 
write code. Only very rarely will you need to think about the "initializer 
section" and "declaration section" in explicit terms. The compiler will let 
you know when you break the rules, and force you to fix your code.

### Initializer section

The initializer section (or just "the initializer") is responsible for 
initializing the state of the new instance of the class, before a reference 
to the new instance is available to clients. The declaration section contains 
members of the class which are only called after the instance has been fully 
initialized.

Consider the following example:

<!-- try-pre: 
    Boolean morning = false;
    Boolean afternoon = false;
    Boolean evening = true;

-->
<!-- try-post:

    Hello("Joe").say();
-->
<!-- check:parse:#93 -->
<!-- cat: 
    Boolean morning = false;
    Boolean afternoon = false;
    Boolean evening = true;
-->
    class Hello(String? name) {
         
        //initializer section:
     
        String greetingForTime {
            if (morning) {
                return "Good morning";
            }
            else if (afternoon) {
                return "Good afternoon";
            }
            else if (evening) {
                return "Good evening";
            }
            else {
                return "Hi";
            }
        }
         
        String greeting;
        if (exists name) {
            greeting = greetingForTime + ", " + name;
        }
        else {
            greeting = greetingForTime;
        }
         
        //declaration section:
         
        shared void say() {
            printMessage(greeting);
        }
         
        shared default void printMessage(String message) {
            print(message);
        }
         
    }

To prevent a reference to a new instance of the class "leaking" before the 
new instance has been completely initialized, the language spec defines the 
following terminology:

> Within a class initializer, a *self reference* to the instance being 
> initialized is either:
>
> * any occurrence of the expression `this` or `super`, unless it also occurs 
>   in the body of a nested class or interface declaration, or
> * any occurrence of the expression `outer` in the body of a class or interface 
>   declaration immediately contained by the class.

Now, according to the language spec:

> A statement or declaration contained in the initializer of a class may 
> not evaluate an attribute, invoke a method, or instantiate a member class upon 
> the instance being initialized, including upon a self reference to the instance 
> being initialized if the attribute, method, or member class:
> 
> * occurs later in the body of the class,
> * is annotated `formal` or `default`, or
> * is inherited from an interface or superclass, and is not refined by a 
>   declaration occurring earlier in the body of the class.
>
> Furthermore, a statement or declaration contained in the initializer of a 
> class may not:
>
> * pass a self reference to the instance being initialized as an argument of 
>   an instantiation, function invocation, or `extends` clause expression or as 
>   the value of a value assignment or specification, 
> * use a self reference to the instance being initialized as an operand of 
>   any operator except the member selection operator, or the `of` operator,
> * return a self reference to the instance being initialized, or
> * narrow the type of a self reference to the instance being initialized 
>   using an assignability [`is`] condition.

(The spec mentions a couple of other restrictions that we'll gloss over here.)

### Declaration section

The declaration section contains the definition of members that don't 
hold state, and that are never called until the instance to which they 
belong has been completely initialized.

According to the language spec:

> The following constructs may not [occur] in the declaration section
> [unless nested inside a member body]:
> 
> * a statement or control structure,
> * a reference declaration,
> * a constructor declaration,
> * a forward-declared function or value declaration not annotated `late`,
> * an `object` declaration with a non-empty initializer section, or
> * an `object` declaration that directly extends a class other than 
>   `Object` or `Basic`.

Note that the rules governing the declaration section of a class body are 
essentially the same rules governing the body of an interface. That makes 
sense, because interfaces don't have initialization logic—what interfaces 
and declaration sections have in common is _statelessness_.

### Gotcha!

Unfortunately, these rules make it a little tricky to set up circular 
references between two objects. This is a problem Ceylon has in common 
with functional languages, which also emphasize immutability. The 
following code produces an error:

<!-- check:none:#94 -->
    class Child(parent) {
        shared Parent parent;
    }
     
    class Parent() {
        shared Child child = 
                Child(this); //compile error: leaks self reference
    }

Fortunately, there's a way around this, though it does sacrifice some 
compile-time safety.

### Tip: using `late` to create circular references

As a slightly adhoc workaround for this problem, we can annotate the 
reference `parent`, suppressing the usual definite initialization checks, 
using the `late` annotation: 

<!-- check:none:#94 -->
    class Child() {
        shared late Parent parent; //no initializer
    }
     
    class Parent() {
        shared Child child = Child();
        child.parent = this; //ok, since Child.parent is late
    }

When a reference is annotated `late`, the checks which normally happen at 
compile time are delayed until runtime.

### Tip: using `late` with annotation-driven frameworks

Certain [widely-used Java frameworks][Java frameworks] depend on direct 
reflection-based access to initialize the fields of annotated classes. 
Examples include [Hibernate][], [CDI][], and [Spring][].

If your Ceylon class has an attribute that is meant to be initialized by 
a framework like this, you'll probably need to annotate it `late` in order 
to suppress the compile-time initialization checks.

A common use-case is dependency injection using `java.inject`:

<!-- try: -->
    class Bean() {
        inject late EntityManager em; //no initializer
    }

On the other hand, use of the `late` annotation isn't necessary if you use 
constructor injection instead of field injection.

<!-- try: -->
    inject
    class Bean(EntityManager em) {
    }

[Java frameworks]: ../interop/#java_ee_and_other_annotation_driven_frameworks
[Hibernate]: http://hibernate.org
[Spring]: http://spring.io/projects
[CDI]: https://docs.oracle.com/javaee/7/tutorial/partcdi.htm

### Tip: lazy initialization

We can abuse the `variable` annotation to arrive at the following idiom for 
lazy initialization of an attribute:

<!-- try-pre:
    Float calculatePi() => 3.14159;
    
-->
<!-- try-post:

    print(HaveYourPi().pi);
-->
    class HaveYourPi() {
        variable Float? _pi = null;
        shared Float pi
            => _pi else (_pi=calculatePi());
    }

A future version of the language will likely offer a better way to do this.

### Definite initialization of functions

Ceylon lets us separate the declaration of a function from the actual 
specification statement that specifies the function implementation.

This applies when a function implementation is specified by assigning
a reference:

<!-- try: -->
    Float(Float) arithmetic(Operation op, Float x) {
        Float fun(Float y);
        switch (op)
        case (plus) { fun = x.plus; }
        case (minus) { fun = x.minus; }
        case (times) { fun = x.times; }
        case (divide) { fun = x.divided; }
        return fun;
    }

Or when a function implementation is specified using a fat arrow:

<!-- try: -->
    Float(Float) arithmetic(Operation op, Float x) {
        Float fun(Float y);
        switch (op)
        case (plus) { fun(Float y) => x+y; }
        case (minus) { fun(Float y) => x-y; }
        case (times) { fun(Float y) => x*y; }
        case (divide) { fun(Float y) => x/y; }
        return fun;
    }

The rules for definite initialization of values apply equally to functions 
defined this way.

## Definite return

While we're on the topic, it's worth noting that the Ceylon compiler, just 
like the Java compiler, also performs definite return checking, to ensure 
that a function or getter always has an explicitly specified return value. 
So, this code compiles without error:

<!-- try-pre:
    value person = "Someone";
    value me = "Me";

-->
<!-- try-post:

    print(greeting);
-->
<!-- cat: void m(String person, String me) { -->
    String greeting {
        if (person==me) {
            return "You're beautiful!";
        }
        else {
            return "You're ugly!";
        }
    }
<!-- cat: } -->

But the following code results in an error at compile time:

<!-- try-pre:
    value person = "Someone";
    value me = "Me";

-->
<!-- try-post:

    print(greeting);
-->
<!-- check:none:Demoing error -->
    String greeting {   //error: greeting does not definitely return
        if (person==me) {
            return "You're beautiful!";
        }
        //or otherwise? what now?
    }

## Constructors

Classes with [initializer parameters](../classes/#creating_your_own_class) 
are very convenient almost all of the time, but very occasionally we run 
into the need for a class with two or more completely separate initialization 
paths. For this relatively rare case, Ceylon allows you to write a class with
separate _constructors_.

### Gotcha!

A class with initializer parameters can't have constructors, so if we need
to add a constructor to a class, the first thing we need to do is rewrite it
without initializer parameters.

### Default constructors

Let's take our [trusty `Polar` class](../classes/#creating_your_own_class),
and rewrite it to use a _default constructor_:

<!-- try-post:
    print(Polar(0.37, 10.0).description);
-->
    "A polar coordinate"
    class Polar {
        
        shared Float angle;
        shared Float radius;
        
        shared new (Float angle, Float radius) {
            this.angle = angle;
            this.radius = radius;
        }
        
        shared Polar rotate(Float rotation) 
                => Polar(angle+rotation, radius);
        
        shared Polar dilate(Float dilation) 
                => Polar(angle, radius*dilation);
        
        shared String description 
                = "(``radius``,``angle``)";
        
    }

This looks a great deal like a constructor declaration in Java or C#,
except that we write the keyword `new` instead of the name of the
class.

The good news is that this refactoring didn't break any clients, who
can still instantiate `Polar` like this:

<!-- try-pre:
    "A polar coordinate"
    class Polar {
        
        shared Float angle;
        shared Float radius;
        
        shared new (Float angle, Float radius) {
            this.angle = angle;
            this.radius = radius;
        }
        
        shared Polar rotate(Float rotation) 
                => Polar(angle+rotation, radius);
        
        shared Polar dilate(Float dilation) 
                => Polar(angle, radius*dilation);
        
        string => "(``radius``,``angle``)";
        
    }
-->
    print(Polar(0.37, 10.0));

Unlike Java and C#, we can't overload a default constructor. Instead,
we must give a distinct name to each additional constructor of the 
class.

Constructors are considered to belong to the initializer section of
the class, so in this case the initializer section extends until the
end of the default constructor declaration.

Of course, all the usual language guarantees about definite 
initialization are still in force, and the compiler will make sure
that every constructor of a class leaves all members of the class
fully initialized. 

### Named constructors

A named constructor declaration looks just like a default constructor,
except that it declares an initial-lowercase name:

<!-- try-post:
    value pt = Polar(0.37, 10.0);
    print(Polar.copy(pt));
-->
    "A polar coordinate"
    class Polar {
        
        shared Float angle;
        shared Float radius;
        
        shared new (Float angle, Float radius) {
            this.angle = angle;
            this.radius = radius;
        }
        
        shared new copy(Polar polar) {
            this.angle = polar.angle;
            this.radius = polar.radius;
        }
        
        shared Polar rotate(Float rotation) 
                => Polar(angle+rotation, radius);
        
        shared Polar dilate(Float dilation) 
                => Polar(angle, radius*dilation);
        
        string => "(``radius``,``angle``)";
        
    }

A reference to a named constructor must be qualified by the
class name, except within the body of the class itself:

<!-- try: -->
    value pt = Polar(0.37, 10.0);
    print(Polar.copy(pt));

### Constructor delegation

A constructor may delegate to:

- another constructor of the class to which it belongs,
  whose declaration occurs earlier in the body of the class, 
  or 
- directly to a constructor of its superclass or to the 
 initializer of its superclass, if any.
 
 Constructor delegation is specified using `extends`:

<!-- try-post:
    print(Polar.onHorizontalAxis(1.0));
-->
    "A polar coordinate"
    class Polar {
        
        shared Float angle;
        shared Float radius;
        
        shared new (Float angle, Float radius) {
            this.angle = angle;
            this.radius = radius;
        }
        
        shared new copy(Polar polar)
            extends Polar(polar.angle, polar.radius) {}
        
        shared new onHorizontalAxis(Float distance)
            extends Polar(0.0, distance) {}
        
        shared Polar rotate(Float rotation) 
                => Polar(angle+rotation, radius);
        
        shared Polar dilate(Float dilation) 
                => Polar(angle, radius*dilation);
        
        string => "(``radius``,``angle``)";
        
    }

If a class directly extends the 
[default superclass](../language-module/#the_default_superclass)
`Basic`, and the constructor does not explicitly delegate to 
another constructor, it is understood to implicitly delegate to 
the initializer of `Basic`.

Constructors of a class which does not directly extend `Basic` 
_must_ explicitly delegate.

Since constructors are restricted to delegate _backwards_, the 
general flow of member initialization in Ceylon is preserved: 
initialization flows forward from the beginning of the body of 
the class, and each member must be initialized before it is 
used. The gory details are covered 
[here](../../../../blog/2015/06/21/constructors/#ordering_of_initialization_logic).

### Constructors and extension

When a class with a constructor 
[extends](../inheritance/#class_inheritance) a class with an 
initializer or default constructor, it specifies just the name 
of the extended class in the `extends` clause, and a regular 
instantiation in the `extends` clause of the constructor:

    class Person(String name) {}

    class Employee 
            extends Person { //just the class name
        shared new withName(String name) 
                extends Person(name) {} //instantiation
    }

When a class with an initializer extends a class with a named
constructor, it may specify the constructor invocation in its
`extends` clause:

    class Person {
        String name;
        shared new withName(String name) {
            this.name = name;
        }
    }

    class Employee(String name) 
            extends Person.withName(name) {} //constructor invocation

When a class with a constructor extends a class with a named 
constructor, it specifies just the name of the extended class 
in the `extends` clause, and a regular constructor invocation 
in the `extends` clause of the constructor:

    class Person {
        String name;
        shared new withName(String name) {
            this.name = name;
        }
    }

    class Employee 
            extends Person { //just the class name
        shared new withName(String name) 
                extends Person.withName(name) {} //constructor invocation
    }

It is legal to delegate to `super` instead of writing `Person`
explicitly:

<!-- try: -->
    class Employee 
            extends Person { //just the class name
        shared new withName(String name) 
                extends super.withName(name) {} //super constructor invocation
    }

It is perfectly legal for each constructor of a class to
delegate to a _different_ constructor of the superclass:

    class Person {
        String name;
        shared new withName(String name) {
            this.name = name;
        }
        shared new withFirstAndLast(String first, String last) {
            this.name = first + ' ' + last;
        }
    }

    class Employee 
            extends Person {
        shared new withName(String name) 
                extends super.withName(name) {}
        shared new withFirstAndLast(String first, String last) 
                extends super.withFirstAndLast(first, last) {}
    }


### Value constructors

A _value constructor_ is a constructor that:

- takes no parameters, and
- is executed exactly once for the context to which the class
  belongs.

Value constructors of toplevel classes are singletons.

<!-- try-post:
    print(Polar.origin);
    print(Polar.onHorizontalAxis(1.0));
-->
    "A polar coordinate"
    class Polar {
        
        shared Float angle;
        shared Float radius;
        
        shared new (Float angle, Float radius) {
            this.angle = angle;
            this.radius = radius;
        }
        
        shared new copy(Polar polar)
            extends Polar(polar.angle, polar.radius) {}
        
        shared new onHorizontalAxis(Float distance)
            extends Polar(0.0, distance) {}
        
        shared new origin extends onHorizontalAxis(0.0) {}
        
        shared Polar rotate(Float rotation) 
                => Polar(angle+rotation, radius);
        
        shared Polar dilate(Float dilation) 
                => Polar(angle, radius*dilation);
        
        string => "(``radius``,``angle``)";
        
    }

A reference to a value constructor must be qualified by the
class name, except within the body of the class itself:

<!-- try: -->
    print(Polar.origin);

### Value constructor enumerations

Finally we've arrived at an alternative, more satisfying, way 
to emulate a Java `enum`. We've already seen how to do it
using [anonymous classes](../types/#enumerated_instances), but
we can also use value constructors:

<!-- try-post:
    void printSuit(Suit suit) {
        switch (suit)
        case (Suit.hearts) { print("Heartzes"); }
        case (Suit.diamonds) { print("Diamondzes"); }
        case (Suit.clubs) { print("Clidubs"); }
        case (Suit.spades) { print("Spidades"); }
    }
-->
    class Suit of hearts | diamonds | clubs | spades {
        String name;
        shared new hearts { name = "hearts"; }
        shared new diamonds { name = "diamonds"; }
        shared new clubs { name = "clubs"; }
        shared new spades { name = "spades"; }
    }

We can use this enumerated type in a `switch`:

<!-- try-pre:
    class Suit of hearts | diamonds | clubs | spades {
        String name;
        shared new hearts { name = "hearts"; }
        shared new diamonds { name = "diamonds"; }
        shared new clubs { name = "clubs"; }
        shared new spades { name = "spades"; }
    }
-->
    void printSuit(Suit suit) {
        switch (suit)
        case (Suit.hearts) { print("Heartzes"); }
        case (Suit.diamonds) { print("Diamondzes"); }
        case (Suit.clubs) { print("Clidubs"); }
        case (Suit.spades) { print("Spidades"); }
    }

You're probably wondering why Ceylon would provide two 
different ways to do essentially the same thing. Well, the
thing is that according to the language specification, an 
`object` _actually is a value constructor!_

When we write:

<!-- try: -->
    object thing {}

That's really just a syntactic abbreviation for:

<!-- try: -->
    class \Ithing {
        shared new thing {}
    }
    \Ithing thing => \Ithing.thing;

## Static members

You're probably familiar with the idea of a _static member_ 
which comes up in many object-oriented languages, including 
C++, Java, and C#. Languages like Smalltalk and Ruby feature 
an almost identical concept called _class members_.

We don't have nearly as much use for static members in Ceylon
as in Java, since we usually just use toplevel methods or
values instead. However, there are occasionally good reasons 
for preferring a static member to a toplevel:

- when a function needs to access private members of a class,
- when a class needs to define private state or constants
  that are shared by all instances, without polluting the
  namespace of the whole package, or
- to define "factory functions".

### Restrictions on static members

Now, of course, there's no [current instance][] for a static 
member, so within a static member we can't:

- make use of `this` or `super`,
- use parameters of the class itself, or
- call non-static members without providing an instance of
  the class.

Therefore, Ceylon doesn't let us write something like this:

<!-- try: -->
    class Class(String name) {
        void instanceMethod() {}
        static void staticMethod() {} //error!
    }

In this code, it looks like `staticMethod()` should have 
access to both the parameter `name`, and the method 
`instanceMethod()`, since they're both in scope, according to 
the usual scoping rules of the language.

So, in order to respect the block structure of the language, 
there's two important restrictions:

- only a class with constructors may define _static members_,
  and
- static members must be defined right at the start of the
  class, _before_ the initializer section, before the
  constructors of the class, and before any regular non-static
  members of the class.

A nested class or anonymous class may not declare static 
members.

[current instance]: #self_references_and_outer_instance_references

### Declaring a static member

We indicate that a method, value, or nested class is `static`
by annotating it:

<!-- try-post:
    
    Greeting.sayHello();
 -->
    shared class Greeting {
        //static members
        static String hello = "Hello";
        shared static void sayHello() => print(hello);
        
        //initializer section
        String name;
        shared new (String name) {
            this.name = name;
        }
        
        //instance method
        shared void greet() => print(hello + " " + name);
    }

Notice how the body of the class is laid out as *three*
different sections:

- static member declarations come first,
- followed by the initializer, along with constructors, 
- and then the declaration section.

### References to static members

Static members are invoked directly on the class itself:

<!-- try: -->
    Greeting.sayHello();

This is a sort of [static reference][], just like what we met 
earlier in the tour. The difference here is that:

- whereas, if `sayHello()` where a regular non-`static` method,
  the type of `Greeting.sayHello` would be `Anything(Greeting)()`,
- in this case, since `sayHello()` is `static`, it has the type
  `Anything()`, allowing us to invoke the method without 
  providing an instance of `Greeting`.

[static reference]: ../functions/#static_method_and_attribute_references

### Tip: using `static` to define a factory

We can use the `static` in conjunction with the idiom for
[lazy initialization](#tip_lazy_initialization) to define
a _factory_:

<!-- try-post:
    
    Greeting.forWholeWorld.greet();
 -->
    shared class Greeting {
        //static member
        static String hello = "Hello";
        
        //a static factory
        shared static variable Greeting? forWorld = null;
        shared static Greeting forWholeWorld
                => forWorld else (forWorld = Greeting("world"));
    
        //initializer section
        String name;
        shared new (String name) {
            this.name = name;
        }
    
        //instance method
        shared void greet() => print(hello + " " + name);
    }

We can call the factory as if it were a constructor:

<!-- try: -->
    Greeting.forWholeWorld.greet();

Unlike in Java, the type parameters of class are considered 
in scope within the definition of a static member. This lets
us call factory functions for generic classes using the same
syntax we just to call a constructor. 

## There's more...

You can read more about constructors [here](/blog/2015/06/21/constructors/).

Now, we're going to discuss [annotations](../annotations), and take a little 
peek at using the metamodel to build framework code. 

