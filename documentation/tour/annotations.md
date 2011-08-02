---
layout: tour
title: Tour of Ceylon&#58; annotations
tab: documentation
author: Gavin King
---

# #{page.title}

## Annotations

If you've made it this far into this series of articles, you've already seen 
lots of annotations. Annotations are *so* important in Ceylon that it's 
extremely difficult to write any code without using them. But we have not 
yet really explored what an annotation *is*.

Let's finally rectify that. The answer is simple: an annotation is a toplevel 
method that returns a subtype of `ConstrainedAnnotation`. 

Here's the definition of a some of our old friends:

<pre class="brush: ceylon">
    shared Deprecated deprecated() {
        return Deprecated();
    }
    shared Description doc(String description) {
        return Description(description.normalize());
    }
    shared Authors by(String... authors) {
        return Authors( from (authors) select (String name) (name.normalize()) );
    }
</pre>

(Note that the third example uses the syntax introduced in XXXX)

Of course, we can define our own annotations. (That's the whole point!)

<pre class="brush: ceylon">
    shared Scope scope(Scope s) { return s; }
    shared Todo todo(String text) { return Todo(text); }
</pre>

Since annotations are methods, annotation names always begin with a lowercase 
letter.

## Annotation arguments

When we specify an annotation with a non-empty parameter list at a program 
element, we need to specify arguments for the parameters of the annotation. 
Just like with a normal method invocation, we have the choice between a
positional argument list or a named argument list. We could write:

<pre class="brush: ceylon">
    doc ("The Hello World program")
</pre>

or:

<pre class="brush: ceylon">
    doc { description="The Hello World program"; }
</pre>

Likewise, we could write:

<pre class="brush: ceylon">
    by ("Gavin", "Stephane", "Emmanuel")
</pre>

or:

<pre class="brush: ceylon">
    by { "Gavin", "Stephane", "Emmanuel" }
</pre>

But with annotations whose arguments are all literal values, we have a third 
option. We can completely eliminate the punctuation, and just list the 
literal values.

<pre class="brush: ceylon">
    doc "The Hello World program"
    by "Gavin"
       "Stephane"
       "Emmanuel"
</pre>

As a special case of this, if the annotation has no arguments, we can just 
write the annotation name and leave it at that. We do this all the time with
annotations like `shared`, `formal`, `default`, `actual`, `abstract`, 
`deprecated`, and `variable`.

## Annotation types

The return type of an annotation is called the *annotation type*. 
Multiple methods may produce the same annotation type. An annotation type 
must be a subtype of `ConstrainedAnnotation`:

<pre class="brush: ceylon">
    doc "An annotation. This interface encodes
         constraints upon the annotation in its
         type arguments."
    shared interface ConstrainedAnnotation&lt;out Value, out Values, in ProgramElement>
            of OptionalAnnotation&lt;Value,ProgramElement> |     
                SequencedAnnotation&lt;Value,ProgramElement>
            satisfies Annotation&lt;Value>
            given Value satisfies Annotation&lt;Value>
            given ProgramElement satisfies Annotated {
        shared Boolean occurs(Annotated programElement) {
            return programElement is ProgramElement;
        }
    }
</pre>

The type arguments of this interface express constraints upon how annotations 
which return the annotation type occur. The first type parameter, 
`Value`, is simply the annotation type itself.

## Annotation constraints

The second type parameter, `Values`, governs how many different annotations 
of given program element may return the annotation type. Notice that
`ConstrainedAnnotation` has an `of` clause telling us that there are only 
two direct subtypes. So any annotation type must be a subtype of one of 
these two interfaces:

* If an annotation type is a suptype of `OptionalAnnotation`, at most one 
annotation of a given program element may be of this annotation type, or, 
otherwise
* if an annotation type is a suptype of `SequencedAnnotation`, more than one
annotation of a given program element may be of this annotation type.

<pre class="brush: ceylon">
    doc "An annotation that may occur at most once at
         a single program element."
    shared interface OptionalAnnotation&lt;out Value, in ProgramElement>
            satisfies ConstrainedAnnotation&lt;Value,Value?,ProgramElement>
            given Value satisfies Annotation&lt;Value>
            given ProgramElement satisfies Annotated {}
    doc "An annotation that may occur multiple times at
         a single program element."
    shared interface SequencedAnnotation&lt;out Value, in ProgramElement>
            satisfies ConstrainedAnnotation&lt;Value,Value[],ProgramElement>
            given Value satisfies Annotation&lt;Value>
            given ProgramElement satisfies Annotated {}
</pre>

Finally, the third type parameter, `ProgramElement`, of `ConstrainedAnnotation`
constrains the kinds of program elements at which the annotation can occur. 
The argument to `ProgramElement` must be a metamodel type. So the argument 
`Type<Number>` would constrain the annotation to occur only at program 
elements that declare a subtype of `Number`. The argument 
`Attribute<Bottom,String>` would constrain the annotation to occur only 
at program elements that declare an attribute of type `String`.

Here's a couple of examples I copied and pasted straight from the 
language spec:

<pre class="brush: ceylon">
    shared interface Scope
            of request | session | application
            satisfies OptionalAnnotation&lt;Scope,Type&lt;Object>> {}
    shared class Todo(String text)
            satisfies OptionalAnnotation&lt;Todo,Annotated> {
        shared actual String string = text;
    }
</pre>

## Reading annotation values at runtime

Annotation values may be obtained by calling the toplevel method 
`annotations()` defined in the language module.

<pre class="brush: ceylon">
    shared Values annotations&lt;Value,Values,ProgramElement>(
                   Type&lt;ConstrainedAnnotation&lt;Value,Values,ProgramElement>> annotationType,
                   ProgramElement programElement)
               given Value satisfies ConstrainedAnnotation&lt;Value,Values,ProgramElement>
               given ProgramElement satisfies Annotated { ... }
</pre>

So to obtain the value of the `doc` annotation of the `Person` class, we write:

<pre class="brush: ceylon">
    String? description = annotations(Description, Person)?.description;
</pre>

Note that the expression `Person` returns the metamodel object for the 
class `Person`, an instance of `ConcreteClass<Person>`.

To determine if the method `stop()` of a class named `Thread` is deprecated, 
we can write:

<pre class="brush: ceylon">
    Boolean deprecated = annotations(Deprecated, Thread.stop) exists;
</pre>

Note that the expression `Thread.stop` returns the metamodel object for the 
method `stop()` of `Thread`, an instance of `Method<Thread,Void>`.

Here's two more examples, to make sure you get the idea:

<pre class="brush: ceylon">
    Scope scope = annotations(Scope, Person) ? request;
    Todo[] todos = annotations(Todo, method);
</pre>

Everything's set up so that `annotations()` returns `Scope?` for the 
optional annotation type `Scope`, and `Todo[]` for the sequenced annotation 
type `Todo`.

Of course, it's much more common to work with annotations in generic code, 
so you're more likely to be writing code like this:

<pre class="brush: ceylon">
    Entry&lt;Attribute&lt;Bottom,Object?>,String> [] attributeColumnNames(Class&lt;Object> clazz) {
        return from (clazz.members(Attribute&lt;Bottom,Object?>))
                select (Attribute&lt;Bottom,Object?> att) (att->columnName(att));
    }
     
    String columnName(Attribute&lt;Bottom,Object?> member) {
        return annotations(Column, member)?.name ? member.name;
    }
</pre>

As you can see, Ceylon annotations are framework-developer-heaven.

## Defining annotations

We've seen plenty of examples of annotations built into Ceylon. Application 
developers don't often define their own annotations, but framework developers 
do this all the time. Let's see how we could define an annotation for 
declarative transaction management in Ceylon.

<pre class="brush: ceylon">
    Transactional transactional(Boolean requiresNew = false) {
        return Transactional(requiresNew);
    }
</pre>

This method simply produces an instance of the class `Transactional` that 
will be attached to the metamodel of an annotated method or attribute. 
The meta-annotation specifies that the annotation may be applied to methods 
and attributes, and may occur at most once on any member.

<pre class="brush: ceylon">
    shared class Transactional(Boolean requiresNew)
            satisfies OptionalAnnotation&lt;Transactional,Member&lt;Bottom,Void>> {
        shared Boolean requiresNew = requiresNew;
    }
</pre>


Now we can apply our annotation to a method of any class.

<pre class="brush: ceylon">
    shared class OrderManager() {
        shared transactional void createOrder(Order order) { ... }
        ...
    }
</pre>

We could specify an explicit argument to the parameter of transactional using 
a positional argument list:

<pre class="brush: ceylon">
    shared transactional (true)
    void createOrder(Order order) { ... }
</pre>

Alternatively, we could use a named argument list:

<pre class="brush: ceylon">
    shared transactional { requiresNew=true; }
    void createOrder(Order order) { ... }
</pre>

We won't need to use reflection in our example, since Ceylon's module 
architecture includes special built-in support for using annotations to add
interceptors to methods and attributes.

## There's more

Next we're going to touch on Ceylons support for [interceptors](../interceptors).
