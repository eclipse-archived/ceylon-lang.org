---
layout: tour
title: Tour of Ceylon&#58; Initialization
tab: documentation
author: Gavin King
---

# #{page.title}

This is the thirteenth part of the Tour of Ceylon. In the [last part](../language-module) we learned 
about the language module, `ceylon.language`. Now we're going to go into the
details of *initialization*.

## Self references and outer instance references

Ceylon features the keywords `this` and `super`, which refer to the current 
instance of a class — the receiving instance of an operation 
(method invocation, member class instantiation, or attribute 
evaluation/assignment), within the body of the definition of the operation. 
The semantics are exactly the same as what you're used to in Java. In 
particular, a reference to a member of `super` always refers to a member of a 
superclass. There is currently no syntax defined for references to a concrete 
member of a superinterface.

In addition to `this` and `super`, Ceylon features the keyword `outer`, which 
refers to the parent instance of the current instance of a nested class.

    class Parent(String name) {
        shared String name = name;
        shared class Child(String name) {
            shared String name = outer.name + "/" + name;
            shared Parent parent { return outer; }
        }
    }

There are some restrictions on the use of `this`, `super`, and `outer`, which 
we'll explore below.


## Multiple inheritance and "linearization"

There's a good reason why `super` always refers to a super*class*, and never 
to a super*interface*.

Ceylon features a restricted kind of multiple inheritance often called 
'mixin inheritance'. Some languages with multiple inheritance or even mixin 
inheritance feature so-called "depth-first" member resolution or 
linearization where all supertypes of a class are arranged into a 
linear order. We believe that this model is arbitrary and fragile.

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
reason why [interfaces are stateless](../inheritance#interfaces_and_mixin_inheritance) in Ceylon.

(Note that these arguments are even stronger in the case of 
[adapter introduction](../inheritance/#introduction), where linearization or statefulness would be even 
more fragile.)

So Ceylon is more restrictive than some other languages here. But we think 
that this restriction makes a subtype less vulnerable to breakage due to 
changes in its supertypes.


## Definite assignment and definite initialization

A really nice feature of Java is that the compiler checks that a local 
variable has definitely been assigned a value before allowing use of the 
local variable in an expression. So, for example, the following code compiles 
without error:

    String greeting;
    if (person==me) {
        greeting = "You're beautiful!";
    }
    else {
        greeting = "You're ugly!";
    }
    print(greeting);

But the following code results in an error at compile time:

    String greeting;
    if (person==me) {
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
not even an instance of `Person`. (It's an instance of `Nothing`, [remember!](../basics)) 
Although evaluation of an uninitialized instance variable could be defined to
result in an immediate runtime exception, that would just be our 
old friend `NullPointerException` creeping back in by the back door. 

Indeed, "few" object-oriented languages  (and possibly none) perform 
the necessary static analysis to ensure definite initialization of instance 
variables, and this is perhaps one of the main reasons why object-oriented 
languages have never featured typesafe handling of `null` values.


## Class bodies

In order to make it possible for the compiler to guarantee definite 
initialization of attributes, Ceylon imposes some restrictions on the body of 
a class. (Remember that Ceylon doesn't have constructors!) Actually, to be 
completely fair, they're not really restrictions at all, at least not from one 
point of view, since you're actually allowed *extra* flexibility in the body 
of a class that you're not allowed in the body of method or attribute 
declarations! But compared to Java, there's some things you're not allowed 
to do.

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

## Initializer section

The initializer section is responsible for initializing the state of the 
new instance of the class, before a reference to the new instance is available 
to clients. The declaration section contains members of the class which are 
only called after the instance has been fully initialized.

Consider the following example:

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
            print(greeting);
        }
         
        default void print(String message) {
            print(message);
        }
         
    }

To prevent a reference to a new instance of the class "leaking" before the 
new instance has been completely initialized, the language spec defines the 
following terminology:

> Within a class initializer, a *self reference* to the instance being 
> initialized is either:
>
> * the expression `this`, unless contained in a nested class declaration, or
> * the expression `outer`, contained in a directly nested class declaration.

Now, according to the language spec:

> A statement or declaration that appears within the initializer of a 
> class may not:
> 
> * evaluate attributes, invoke methods, or instantiate member classes that are 
>   declared later in the body of the class upon the instance that is being 
>   initialized, including upon a *self reference* to the instance being 
>   initialized.
> * pass a *self reference* to the instance being initialized as an argument 
>   of an instantiation or method invocation or as the value of an attribute 
>   assignment or specification.
> * return a *self reference* to the instance being initialized.
> * evaluate attributes, invoke methods, or instantiate member classes 
>   declared in the declaration section of a superclass of the instance being 
>   initialized, including upon a self reference to the instance being initialized.
> * invoke or evaluate a formal member of the instance being initialized, 
>   including upon a *self reference* to the instance being initialized.
> * invoke or evaluate a default member of the instance that is being 
>   initialized, except via the special `super` self reference.

## Declaration section

The declaration section contains the definition of members that don't 
hold state, and that are never called until the instance to which they 
belong has been completely initialized.

According to the language spec:

> [The declaration section] may not contain:
> 
> * a statement or control structure, unless it is nested inside a method, 
>   attribute, nested class, or nested interface declaration,
> * a declaration with a specifier or initializer, unless it is nested 
>   inside a method, attribute, nested class, or nested interface declaration,
> * an object declaration with a non-empty initializer section, or
> * a specification or initialization statement for a member of the 
>   instance being initialized.
> 
> However, the declarations in this second section may freely use `this` 
> and `super`, and may invoke any method, evaluate any attribute, or 
> instantiate any member class of the class or its superclasses. Furthermore, 
> the usual restriction that a declaration may only be used by code that 
> appears later in the block containing the declaration is relaxed. 

Note that the rules governing the declaration section of a class body are 
essentially the same rules governing the body of an interface. That makes 
sense, because interfaces don't have initialization logic — what interfaces and 
declaration sections have in common is statelessness.


## Circular references

Unfortunately, these rules make it a little tricky to set up circular 
references between two objects without resort to non-`variable` attributes. 
This is a problem Ceylon has in common with functional languages, which also 
emphasize immutability. We can't write the following code in Ceylon:

    abstract class Child(Parent p) {
        shared formal Parent parent = p;
    }
     
    class Parent() {
        shared Child child = Child(this); //compile error (this passed as argument in initializer section)
    }

Eventually, Ceylon will probably need some specialized machinery for dealing 
with this problem, but for now, here is a partial solution:

    abstract class Child() {
        shared formal Parent parent;
    }
     
    class Parent() {
        shared object child extends Child() {
            shared actual parent {
                return outer;
            }
        }
    }


## Definite initialization of methods

Ceylon lets us separate the declaration of a method defined using a method 
reference from the actual specification statement that specifies the method 
reference.

    Float x = ... ;
    Float op(Float y);
    switch (symbol)
    case ("+") { op = x.plus; }
    case ("-") { op = x.minus; }
    case ("*") { op = x.times; }
    case ("/") { op = x.divided; }

The rules for definite initialization of locals and attributes also apply to 
methods defined using a specification statement.


## Definite return

While we're on the topic, it's worth noting that the Ceylon compiler, just 
like the Java compiler, also performs definite return checking, to ensure 
that a method or getter always has an explicitly specified return value. 
So, this code compiles without error:

    String greeting {
        if (person==me) {
            return "You're beautiful!";
        }
        else {
            return "You're ugly!";
        }
    }

But the following code results in an error at compile time:

    String greeting {   //error: greeting does not definitely return
        if (person==me) {
            return "You're beautiful!";
        }
    }


## There's more...

Now, we're going to discuss [annotations](../annotations), and take a little 
peek at using the metamodel to build framework code. 

