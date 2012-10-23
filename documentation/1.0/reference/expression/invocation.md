---
layout: reference
title: Method Invocation
tab: documentation
unique_id: docspage
author: Tom Bentley
milestone: Milestone 1
doc_root: ../..
---

# #{page.title}

Method invocation transfers execution to the given method.

## Usage 

A simple example of postional invocation:

<!-- implicit-id:m: void m(Integer i, String s) {} -->

<!-- cat-id:m -->
<!-- cat: void wrapper() { -->
    m(2, "bonjour"); 
<!-- cat: } -->

A simple example of named argument invocation:

<!-- cat-id: m -->
<!-- cat: void wrapper() { -->
    m{
        s = "ola";
        i = 5;
    };
<!-- cat: } -->


## Description

### Postional Invocation

Syntactically, postional invocation uses parentheses (`(` and `)`) to 
enclose the arguments which are separated with commas (`,`).

Parameters with [default values](../../structure/method#defaulted_parameters) 
may be omitted from the argument list.

For example, given a method `m` [declared](../../structure/method) like this

<!-- id: m -->
    void m(Integer i, String s="hello", Boolean... b) {
        /* method block: statements */
    }
    
then positional invocations look like this:

<!-- cat-id: m -->
<!-- cat: void x() { -->
    m(1);   // default parameter, empty sequence
    m(2, "bonjour");  // empty sequence
    m(3, "guttentag", true); // singleton sequence
    m(4, "guttentag", true, true);
    Iterable<Boolean> someBooleans = {true, true, false};
    m(4, "guttentag", someBooleans...);
<!-- cat: } -->

### Named Argument Invocation

Syntactically, named argument invocation uses braces (`{` and `}`) to 
enclose the arguments which are separed with semicolons (`;`). The last 
named argument must also have a semicolon. Each named argument consists of the 
argument name separated from the expression with the equals (`=`) specifier.

A named argument invocation's final argument may be unnamed if it was 
declared as a [sequenced parameter](../../structure/method#sequenced_parameter).

For example given a method `m` [declared](../../structure/method) like this

<!-- id: m -->
    void m(Integer i, String s="hello", Boolean... b) {
        /* method block: statements */
    }
    
then named argument invocations look like this:

<!-- cat-id: m -->
<!-- cat: void x() { -->
    m{
        s = "ola";
        i = 5;
    };
     
    m{
        b = {true, false};
        s = "你好";
        i = 6;    
    };
    
    m{
        s = "Kia ora";
        i = 7;
        true, true, false
    };
    
    Iterable<Boolean> someBooleans = {true, true, false};
    m{
        s = "Kia ora";
        i = 7;
        someBooleans...
    };
<!-- cat: } -->

### Sequenced arguments

The arguments (if any) to a sequenced parameter are called the 
*sequenced arguments*. Sequenced arguments can be passed in two ways:

1. If you already have an `Iterable` expression whose elements you'd like to 
   use as the sequenced arguments you can pass it by appending ellipsis 
   (`...`) to the argument expression. 
2. You can provide a comma-separated list of expressions to pass as the 
   sequenced arguments. The compiler will evaluate the expressions and wrap 
   them in an `Iterable` for you.

**Caution:** Because a sequenced parameter can be declared with a default value 
just like any other parameter, care must be taken when you want to use an 
`Empty` argument. Consider the following method:

    void tricky(Object... args = {1, 2, 3}) {
        // whatever
    }
    
If we call `tricky()` with no arguments in positional style, or use the unnamed
sequenced argument version of named invocation, then the default
value for the parameter will take effect:

    tricky(); // same as calling tricky(1, 2, 3)
    tricky{};
    
What about the following:

    tricky({});
    
Because of the parameter args is of type `Object...` there could be two 
interpretations for this. We might mean "call tricky() with 
the argument, `{ {} }`" or we could mean 
"call tricky() with the empty sequence `{}`. The compiler assumes
the first interpretation.

There are a couple of ways we can make sure we get what we want, we can 
either name the sequenced argument in a named argument invocation:

    tricky{
        args={};
    };
    
Or we can use ellipsis in the invocation:

    tricky({}...);

### Comprehensions

A [comprehension](../comprehensions) provides a convenient way of passing
(some of) the (possibly transformed) elements returned from an `Iterable` as the 
sequenced arguments.

See the reference on [comprehensions](../comprehensions) for more details.


### Callable invocation

TODO

### Callable arguments

TODO

### Object arguments

TODO

## See also

* [Comprehensions](../comprehensions)
* [`Callable`](#{page.doc_root}/api/ceylon/language/interface_Callable.html) API documentation,
