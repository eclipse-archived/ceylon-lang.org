---
layout: reference12
title_md: 'Named argument lists'
tab: documentation
unique_id: docspage
author: Tom Bentley
---

# #{page.title_md}

A named argument list is not an expression itself, but is used in the formation of 
[invocation expressions](../invocation/).

## Usage 

A *named argument list* is a series of "named arguments" enclosed in braces
and separated with semicolons.
This example of an invocation of a `put` function uses 
[specified arguments](#specified_arguments).

<!-- try: -->
    put {
        integer=1;
        name="one";
    }

## Description

The name given to each argument within the argument list identifies the 
corresponding parameter in the [parameter list](../../structure/parameter-list) 
of the declaration
being invoked. This is in contrast to positional argument lists, 
where the correspondence between argument and parameter is 
done using the position in the list. This means that the order of 
the name arguments can differ from the order of the 
corresponding parameters, so the following 
invocations are equivalent:

    put{
        integer=1;
        name="one";
    };
    put{
        name="one";
        integer=1;
    };

Note that you cannot use a named argument list in an 
[indirect invocation](../invocation#indirect_invocation).

One way to think about named arguments is as a list of *statements*, 
(as opposed to the list of expressions used in a positional invocation).

Named argument lists are made of up of arguments of four different kinds:

* [specified arguments](#specified_arguments),
* [getter arguments](#getter_arguments),
* [function arguments](#function_arguments),
* [object arguments](#object_arguments)

followed by any of the arguments permitted in a positional argument list 
(called [anonymous arguments](#anonymous_arguments) 
because they don't have a name, unlike the others).

**Note:** It is conventional to format each named argument on its 
own line and indented with respect to the braces enclosing the list:

    //like this
    Person {
        name="eve";
    }
    // rather than like this
    Person { name="eve"; };

### Specified Arguments

A specified argument looks a lot like the specification or assignment of 
a reference to a value. In this example we're assigning the parameter 
`val` to the result of the expression `"hello world"`:

    print{
        val="hello world";
    };

### Getter Arguments

Declarations support [reference values](../../structure/value#references) and 
[getter values](../../structure/value#getters), and so it is with
named arguments:

    print{
        value val { 
            return "hello world";
        };
    }
    
And if the result can be computed using just a single statement, you 
can use fat arrow (`=>`) instead of using a block:

    print{
        value val=>"hello world";
    }

### Function Arguments

If a parameter has `Callable` type we can pass an inline-declared function
(whose name matches the parameter name) using named arguments, like this:

    Iterable<Integer> numbers = 0..100;
    value evens = numbers.filter{
        function selecting(Integer number) {
            return number % 2 == 0;
        }
    };
        
If the function consists of a single statement we can alternatively 
use fat arrow (`=>`):

    value evens = numbers.filter{
        function selecting(Integer number) => number % 2 == 0;
    };


### `object` Arguments

We can pass an inline-declared class using `object`
like this:

    value dist = distanceBetween {
        object start implements SphericalPoint {
            shared actual String string = "London";
            shared actual Double latitude = 51.507222;
            shared actual Double longitude = -0.1275;
        },
        object end implements SphericalPoint {
            shared actual String string = "New York";
            shared actual Double latitude = 40.7127;
            shared actual Double longitude = -74.0059;
        }
    };

### Anonymous Arguments

The last arguments in a named argument list are just a comma separated 
list of [positional arguments](../positional-argument-list/) 
(which will commonly be an empty list). 

This argument list is interpreted as a single argument to a parameter 
of type `Iterable`.
 
    // two listed anonymous arguments
    HashSet{ 
        initialCapacity=2;
        "hello", "world"
    };
    
    // a spread anonymous argument
    HashSet{ 
        initialCapacity=2;
        *elements
    };
    
    // a comprehension anonymous argument
    HashSet{ 
        initialCapacity=2;
        for (name in names) "hello ``name``"
    };


## See also

* The reference on [invocation](../invocation/)
* The reference on [positional argument lists](../positional-argument-list/)
