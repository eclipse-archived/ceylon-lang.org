---
title: Ceylon M6 progress report
author: Gavin King
layout: blog
unique_id: blogpage
tab: blog
tags: [progress]
---
So it looks like it's time again for me to offer my usual 
lame excuses for another late milestone release of Ceylon.
Well, I suppose all that really matters is: it's coming 
soon!

Ceylon M6 will be the first feature-complete implementation
of the language specification, incorporating the following 
headline changes:

- new syntax for invoking super-interface members,
- nonempty variadic parameters
- `try` with resources,
- "static" member references,
- metamodel and metamodel expressions, and
- annotations.

We have not yet decided if support for serialization will
make it into M6.

Invoking super-interface members
--------------------------------

Previously, we were using a rather ugly and arbitrary 
syntax, for example, `List::equals(that)` to invoke an 
overridden member of a superinterface. Now we can just
write `super.equals(that)`, except in cases where this
is ambiguous (the member is ambiguously inherited from 
more than one supertype), in which case you can use the
widening `of` operator `(super as List<T>).equals(that)`.
(We now treat `super` essentially as a value whose type 
is the intersection of all immediate supertypes of the
current type.)

Nonempty variadic parameters
----------------------------

You may now define a variadic function that requires at
least one argument, for example:

    String max(String+ strings) {
        value max = strings.first;
        for (string in strings.rest) {
            if (string>max) {
                max = string;
            }
        }
        return max;
    }

The type of such a function is written `String(String+)`,
meaning, of course, `Callable<String,[String+]>.

`try` with resources
--------------------

The `try (Transaction()) { ... }` construct works almost 
exactly like in Java.

Static member references
------------------------

Static member references let us obtain a reference to a
member of a type without providing an instance of the
type. For example:

- `Person.name` refers to the attribute `name` declared
  by the class `Person`, and
- `Object.equals` refers to the method `equals` declared
  by the class `Object`.

The type of a static method reference is a function type
where the first parameter list accepts an instance of
the type that declares the member.

- `Person.name` is of type `String(Person)`, and
- `Object.equals` is of type `Boolean(Object)(Object)`.

Static attribute references are especially useful, since
we can pass them directly to `map()`:

    Person[] people = .... ;
    {String*} names = people.map(Person.name);

This functionality is already working.

The metamodel
-------------

We call Ceylon a "higher-order" language partly because 
functions, classes, methods, and attributes are typed 
values. For example, the class `Person` is a value of 
type `Person(Name)`:

    Person(Name) createPerson = Person;
    Person person = createPerson(Name("Gavin", "King"));

However, Ceylon takes the notion of "higher-order" 
significantly further. The language lets us write 
typesafe code that reasons about the program itself, by
providing a typesafe _metamodel_. 

A metamodel expression is enclosed in backticks:

    Class<Person,[Name]> personClass = `Person`;
    Attribute<Person,Name> nameAttribute = `Person.name`;
    Method<Object,Boolean(Object)> equalsMethod = `Object.equals`;

We can use a metamodel to obtain the name and annotations
of a declaration, or to query a type for members by their
type, parameter types, annotations, etc.

It's taking us a bit of work to get the metamodel just 
right, and that's the main thing that has been holding 
up the M6 release.

Annotations
-----------

Annotations are discussed (here)(/documentation/1.0/tour/annotations/).
The basic concept hasn't changed much in our initial
implementation.
