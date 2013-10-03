---
layout: reference
title: '`*.` (spread method) operator'
tab: documentation
unique_id: docspage
author: Tom Bentley
doc_root: ../../..
---

# #{page.title}

The *spread method* operator maps an iterable of instances through a 
method, resulting in a new iterable containing the return values of
each method invocation.

## Usage 

<!-- try: -->
    {String+} names = {"foo", "bar", "baz"};
    {String+} initials = names*.initial(1);

You can also spread method references:

<!-- check:none -->
<!-- try: -->
    Callable<String[], [Integer]> ref = names*.initial;
    
### Definition

See the [language specification](#{site.urls.spec_current}#listmap) for 
more details.

### Polymorphism

The `*.` operator is not [polymorphic](#{page.doc_root}/reference/operator/operator-polymorphism). 

### Type

The result type of the `lhs*.rhs` operator is the callable type of the 
type of the right hand operand, with the return type replaced by its
corresponding sequential type.


## See also

* [`*.` (spread attribute)](../spread-attribute) operator, the equivalent of the 
  spread method operator but for attributes;
* [sequence operators](#{site.urls.spec_current}#listmap) in the 
  language specification
* [operator precedence](#{site.urls.spec_current}#operatorprecedence) in the 
  language specification
* [Operator polymorphism](#{page.doc_root}/tour/language-module/#operator_polymorphism) 
  in the Tour of Ceylon

