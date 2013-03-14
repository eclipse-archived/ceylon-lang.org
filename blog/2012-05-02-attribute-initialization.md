---
title: New syntax for attribute initialization
author: Gavin King
layout: blog
unique_id: blogpage
tab: blog
tags:
---

I think perhaps the least ergonomic syntactic feature of Ceylon 
has been the syntax for attribute initialization. I never ever 
managed to get comfortable writing the following:

<!-- try: -->
    //old syntax!
    class Person(String name, Integer age=0) {
        shared String name = name;
        shared variable Integer age:=age;
    }

Now, I hate the verbosity of C++/Java-style constructors, but 
one thing they definitely have going for them is that they give 
you distinct namespaces for class members and constructor 
parameters. Ceylon's more compact syntax doesn't give you that, 
so we had to come up with the ad hoc rule that parameter names 
hide attribute names, since we didn't want people to be forced 
to always name parameters like `initialName`, `initialAge`, etc.

Worse, this ad hoc rule results in some fairly pathological 
stuff. Consider:

<!-- try: -->
    //old syntax!
    class Person(String name, Integer age=0) {
        shared String name = name;
        shared variable Integer age:=age;
        this.age:=1;
        print(age); //would print 0 
    }

So we were forced to add some extra smelly rules to let the 
compiler detect and prevent things like this.

Well, this solution has finally worn out its welcome. We've 
decided to take a different approach in M3. (Indeed, I just 
finished updating the language spec and type checker.)

Now, the above can be written like this:

<!-- try: -->
    class Person(name, age=0) {
        shared String name;
        shared variable Integer age;
    }

That is, a parameter declaration can now simply be a reference 
to an attribute, in which case its type is inferred from the 
type of the attribute. The parameter itself is never addressable 
in the body of the class, but it's argument is automatically 
used to initialize the attribute. That is, there's only one 
unambiguous thing called `age`:

<!-- try: -->
    class Person(name, age=0) {
        shared String name;
        shared variable Integer age;
        age:=1;
        print(age); //prints 1 
    }

The really nice thing about this solution is that it gives us 
an extremely terse and well-organized syntax for "data holder" 
classes.

<!-- try: -->
    class Address(street, city, state, zip, country) {

        doc "the street, street number, 
             and unit number"
        shared String street;
        
        doc "the city or municipality"
        shared String city;
        
        doc "the state"
        shared String state;
        
        doc "the zip or post code"
        shared String zip;
        
        doc "the country code"
        shared String country;
        
    }

I think it would be hard to come up with a more readable syntax 
than this!

UPDATE: It's interesting to compare this solution to the 
[syntax used by Dart][], which is along the same lines. I swear 
I didn't copy!  

[syntax used by Dart]: http://www.dartlang.org/language-tour/#classes