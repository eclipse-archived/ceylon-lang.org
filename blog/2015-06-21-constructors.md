---
title: Constructors in Ceylon
author: Gavin King
layout: blog
unique_id: blogpage
tab: blog
tags: [constructors, 1.2]
---

Since the earliest versions of Ceylon, we've supported a
streamlined syntax for class initialization where the 
parameters of a class are listed right after the class name, 
and initialization logic goes directly in the body of the 
class.

<!-- try: -->
    class Color(shared Integer rgba) {
        
        assert (0 <= rgba <= #FFFFFFFF);
        
        function encodedValue(Integer slot)
                => rgba.rightLogicalShift(8*slot).and(#FF);
        
        shared Integer alpha => encodedValue(3);
        
        shared Integer red => encodedValue(2);
        shared Integer green => encodedValue(1);
        shared Integer blue => encodedValue(0);
        
        function hex(Integer int) => formatInteger(int, 16);
        
        string => "Color { \
                   alpha=``hex(alpha)``, \
                   red=``hex(red)``, \
                   green=``hex(green)``, \
                   blue=``hex(blue)`` }";
        
    }

We can instantiate a class like this:

<!-- try: -->
    Color red = Color(#FFFF0000);

The ability to refer to parameters of the class directly
from the members of the class really helps cut down on
verbosity, and most of the time this is a really comfortable
way to write code.

However, as we've seen over the past few years of writing
Ceylon code, there are moments when we would really 
appreciate the ability to write a class with multiple
initialization paths, something like constructors in Java,
C#, or C++. To be clear, in the overwhelmingly common 
case&mdash;something more than 90% of classes, I would 
estimate&mdash;constructors are unnecessary and uncomfortable.
But we still need a good solution for the remaining trickier
cases.

Unfortunately, I've always found the design of constructors
that Java and C# inherited from C++ to be a bit strange and
inexpressive. So before I tell you what we've done about
constructors in Ceylon 1.2, let me start by explaining what
I think is wrong with constructors in Java.

## What's wrong with constructors in Java?

As alluded above, the biggest problem with the constructor
syntax in languages that borrow from C++ is that in the 
common case of a class with just one constructor, the
parameters of that constructor aren't available in the body
of the class, leading to awful code like the following:

<!-- try: -->
<!-- lang: java -->
    class Point {
        public float x;
        public float y;
        public Point(float x, float y) {
            this.x = x;
            this.y = y;
        }
        public String toString() {
            return "(" + x + ", " + y + ")";
        }
    }

This hurts. Fortunately, we've already made that pain go 
away in Ceylon. So let's look at some additional issues with 
constructors in Java.

To begin with, the syntax is irregular. In C-like languages, 
the grammar for a declaration is:

<!-- try: -->
    modifier* (Keyword|Type) Identifier OtherStuff

Constructors, strangely, don't conform to this general 
schema, having been bolted on later.

Second, the constructors of a class are all forced to have 
the same name. This seems like a quite bizarre restriction:

- If they all have the same name, why not declare them with 
  a keyword instead of an identifier? DRY, anyone? 
- It's a restriction that robs me of expressiveness. Instead 
  of `new ColorWithRGBAndAlpha(r,g,b,a)`, giving me a clue 
  as to the semantics of the arguments, I write just 
  `new Color(r,g,b,a)`, and the reader is left guessing.
- Constructors thus run into Java's totally broken support 
  for overloading. I can't have a constructor that takes
  a `List<Float>` and another which takes a `List<Integer>`,
  since these two parameter types have the same erasure.
- Constructor references (`Constructor::new` in Java) can
  be ambiguous, depending on the context.

Third, constructors aren't forced to initialize the instance
variables of the class. All Java types have a "default"
(zero or null) value, and if you forget to initialize an
instance variable in Java, you'll get a `NullPointerException`,
or, worse, an incorrect zero value at runtime. These problems
most certainly belong to the class of problems that I expect
a static type system to be able to detect, and, indeed, in
other contexts Java _does_ detect uninitialized variables.

Further note that this would be an even bigger problem in 
Ceylon, because most types don't have `null` as an instance,
so there is no obvious "default" value.

As usual, my purpose here isn't to bash Java, but to justify
why we've done things differently in Ceylon.

## Named constructors and  default constructors

By contrast, the newly introduced syntax for constructors in 
Ceylon is regular, expressive, and doesn't rely on 
overloading (which Ceylon doesn't support, except when 
interoperating with native Java code).

<!-- try: -->
    class Color {
        
        shared Integer rgba;
        
        //default constructor
        shared new (Integer rgba) {
            assert (0 <= rgba <= #FFFFFFFF);
            this.rgba = rgba;
        }
        
        //named constructor
        shared new withRGB(
            Integer red, Integer green, Integer blue, 
            Integer alpha = #FF) {
            assert (0 <= red <= #FF, 
                    0 <= green <= #FF, 
                    0 <= blue <= #FF);
            this.rgba = 
                    alpha.leftLogicalShift(24) +
                    red.leftLogicalShift(16) +
                    green.leftLogicalShift(8) +
                    blue;
        }
        
        //another named constructor
        shared new withRGBIntensities(
            Float red, Float green, Float blue, 
            Float alpha = 1.0) {
            assert (0.0 <= red <= 1.0, 
                    0.0 <= green <= 1.0, 
                    0.0 <= blue <= 1.0);
            function int(Float intensity) 
                    => (intensity*#FF).integer;
            this.rgba = 
                    int(alpha).leftLogicalShift(24) +
                    int(red).leftLogicalShift(16) +
                    int(green).leftLogicalShift(8) +
                    int(blue);
        }
        
        function encodedValue(Integer slot)
                => rgba.rightLogicalShift(8*slot).and(#FF);
        
        shared Integer alpha => encodedValue(3);
        
        shared Integer red => encodedValue(2);
        shared Integer green => encodedValue(1);
        shared Integer blue => encodedValue(0);
        
        function hex(Integer int) => formatInteger(int, 16);
        
        string => "Color { \
                   alpha=``hex(alpha)``, \
                   red=``hex(red)``, \
                   green=``hex(green)``, \
                   blue=``hex(blue)`` }";
        
    }

Constructor declarations are indicated with the keyword `new`,
and have a name which begins with a lowercase letter. We call
a constructor like this:

<!-- try: -->
    Color red = Color.withRGBIntensities(1.0, 0.0, 0.0);

Or, using named arguments, like this:

<!-- try: -->
    Color red = 
        Color.withRGBIntensities { 
            red = 1.0; 
            green = 0.0;
            blue = 0.0;
        };

A function reference to a constructor has a natural syntax:

<!-- try: -->
    Color(Float,Float,Float) createColor
            = Color.withRGBIntensities;

A class may have a constructor, called the _default constructor_,
with no name. Instantiation via the default constructor works
just like instantiation of a class without constructors:

<!-- try: -->
    Color red = Color(#FFFF0000);

A class isn't required to have a default constructor, but
most classes will have one.

Why do we need the concept of a default constructor? Well,
because a class with constructors _may not have a parameter
list_. Wait, let's stop and reemphasize that caveat, because 
it's an important one:

> You can't add constructors to a class with a parameter 
> list! Instead, you must first rewrite the class to use
> a "default constructor" for its "normal" initialization
> logic. 

However, a class with constructors may still have 
initialization logic directly in the body of the class. For
example, the following is perfectly legal:

<!-- try: -->
    class Color {
        
        shared Integer rgba;
        
        shared new (Integer rgba) {
            this.rgba = rgba;
        }
        
        shared new withRGB(
            Integer red, Integer green, Integer blue, 
            Integer alpha = #FF) {
            assert (0 <= red <= #FF, 
                    0 <= green <= #FF, 
                    0 <= blue <= #FF);
            this.rgba = 
                    alpha.leftLogicalShift(24) +
                    red.leftLogicalShift(16) +
                    green.leftLogicalShift(8) +
                    blue;
        }
        
        shared new withRGBIntensities(
            Float red, Float green, Float blue, 
            Float alpha = 1.0) {
            assert (0.0 <= red <= 1.0, 
                    0.0 <= green <= 1.0, 
                    0.0 <= blue <= 1.0);
            function int(Float intensity) 
                    => (intensity*#FF).integer;
            this.rgba = 
                    int(alpha).leftLogicalShift(24) +
                    int(red).leftLogicalShift(16) +
                    int(green).leftLogicalShift(8) +
                    int(blue);
        }
        
        //executed for every constructor
        assert (0 <= rgba <= #FFFFFFFF);
        
        //other members
        ...
    }

The last `assert` statement is executed every time the class
is instantiated.

## Value constructors

The constructors we've just seen are termed _callable 
constructors_ in the language specification, because they
declare parameters. We also have _value constructors_, which
don't declare parameters, and which are executed once, the
first time the constructor is evaluated in the context to
which the class belongs. For a toplevel class, a value 
constructor is a singleton.

<!-- try: -->
    class Color {
        
        shared Integer rgba;
        
        //default constructor
        shared new (Integer rgba) {
            this.rgba = rgba;
        }
        
        //value constructors
        
        shared new white {
            this.rgba = #FFFFFFFF;
        }
        
        shared new red {
            this.rgba = #FFFF0000;
        }
        
        shared new green {
            this.rgba = #FF00FF00;
        }
        
        shared new blue {
            this.rgba = #FF0000FF;
        }
        
        //etc
        ...
        
    }

We can use a value constructor like this:

<!-- try: -->
    Color red = Color.red;

Sometimes the constructors of a class share certain 
initialization logic. If that logic doesn't depend upon the
parameters of the class, we can put it directly in the body
of the class, as we've already seen. But if it _does_ depend
upon the parameters, we often need to take a different tack.

## Constructor delegation

To facilitate reuse of initialization logic within a class, 
it's useful to allow a constructor to delegate to a different
constructor of the same class. For this, we use the `extends`
clause:

<!-- try: -->
    Integer int(Float intensity) 
            => (intensity*#FF).integer;
    
    class Color {
        
        shared Integer rgba;
        
        shared new (Integer rgba) {
            this.rgba = rgba;
        }
        
        //value constructors delegate to the default constructor
        
        shared new white 
                extends Color(#FFFFFFFF) {}
        
        shared new red 
                extends Color(#FFFF0000) {}
        
        shared new green 
                extends Color(#FF00FF00) {}
        
        shared new blue 
                extends Color(#FF0000FF) {}
        
        shared new withRGB(
            Integer red, Integer green, Integer blue, 
            Integer alpha = #FF) {
            assert (0 <= red <= #FF, 
                    0 <= green <= #FF, 
                    0 <= blue <= #FF);
            this.rgba = 
                    alpha.leftLogicalShift(24) +
                    red.leftLogicalShift(16) +
                    green.leftLogicalShift(8) +
                    blue;
        }
        
        shared new withRGBIntensities(
            Float red, Float green, Float blue, 
            Float alpha = 1.0) 
                //delegate to other named constructor
                extends withRGB(int(red), 
                                int(green), 
                                int(blue)) {}
        
        assert (0 <= rgba <= #FFFFFFFF);
        
        //other members
        ...
    }

A constructor may only delegate to a constructor defined
earlier in the body of the class.

Note that we've written `extends Color(#FFFFFFFF)` to 
delegate to the default constructor of `Color`.

## Definite initialization and partial constructors

An ordinary constructor like `Color.withRGB()` or 
`Color.withRGBIntensities()` has a responsibility to 
initialize every value reference belonging to the class that 
is either:

- `shared`, or
- used ("captured") by another member of the class.

The Ceylon compiler enforces this responsibility at compile
time and will reject the code unless it can prove that every
value reference has been fully initialized, either:

- by every ordinary constructor, or
- in the body of the class itself.

This rule would make it difficult to factor out common logic
contained in constructors if it weren't for the notion of a
_partial constructor_. For a partial constructor, the 
requirement that all references are fully initialized is
relaxed. But a partial constructor may not be used to 
directly instantiate the class. It may only be called from
the `extends` clause of another constructor of the same 
class. A partial constructor is indicated by the `abstract`
annotation: 

Here's a contrived example:

<!-- try: -->
    class ColoredPoint {
        shared Point point;
        shared Color color;
        
        //partial constructor
        abstract new withColor(Color color) {
            this.color = color;
        }
        
        shared new forCartesianCoords(Color color, 
            Float x, Float y) 
                //delegate to partial constructor
                extends withColor(color) {
            point = Point.cartesian(x, y);
        }

        shared new forPolarCoords(Color color, 
            Float r, Float theta) 
                //delegate to partial constructor
                extends withColor(color) {
            point = Point.polar(r, theta);
        }
        
        ...
        
    }

So far, we've only seen how to delegate to another 
constructor of the same class. But when a class extends a
superclass, every constructor must ultimately 
delegate&mdash;perhaps indirectly&mdash;to a constructor of 
the superclass.

## Constructors and inheritance

A class may extend a class with constructors, for example:

<!-- try: -->
    class ColoredPoint2(color, Float x, Float y) 
            extends Point.cartesian(x, y) {
        shared Color color;
        ...
    }

A more interesting case is when the extending class itself
has constructors:

<!-- try: -->
    class ColoredPoint extends Point {
        shared Color color;
        
        shared new forCartesianCoords(Color color, 
            Float x, Float y)
                //delegate to Point.cartesian()
                extends cartesian(x, y) {
            this.color = color;
        }

        shared new forPolarCoords(Color color, 
            Float r, Float theta)
                //delegate to Point.polar()
                extends polar(r, theta) {
            this.color = color;
        }
        
        ...
    }

In this example, the constructors delegate directly to 
constructors of the superclass.

### Ordering

With constructor delegation, together with initialization 
logic defined directly in the body of the class, you must
be imagining that initialization can get pretty convoluted.

Well, no. The general principle of initialization in Ceylon
remains unchanged: initialization always flows from top to 
bottom, allowing the typechecker to verify that every `value` 
is initialized before it is used.

Consider this class:

<!-- try: -->
    class Class {
        print(1);
        abstract new partial() {
            print(2);
        }
        print(3);
        shared new () extends partial() {
            print(4);
        }
        print(5);
        shared new create() extends partial() {
            print(6);
        }
        print(7);
    }

Calling `Class()` results in the following output:

<!-- try: -->
    1
    2
    3
    4
    5
    7

Calling `Class.create()` results in this output:

<!-- try: -->
    1
    2
    3
    5
    6
    7

All quite orderly and predictable!

## Using value constructors to emulate enums 

If a class _only_ has value constructors, it's very similar 
to a Java `enum`.

<!-- try: -->
    shared class Day {
        shared actual String string;
        abstract new named(String name) {
            string = name;
        } 
        shared new sunday extends named("SUNDAY") {}
        shared new monday extends named("MONDAY") {}
        shared new tuesday extends named("TUESDAY") {}
        shared new wednesday extends named("WEDNESDAY") {}
        shared new thursday extends named("THURSDAY") {}
        shared new friday extends named("FRIDAY") {}
        shared new saturday extends named("SATURDAY") {}
    }

But Ceylon goes a little further than Java here. If we add 
an `of` clause to `Day`, it will be considered a "closed"
enumeration. That is, an enumeration that won't grow new
value constructors in future revisions of the class.

<!-- try: -->
    shared class Day 
            of sunday |monday | tuesday | wednesday | 
               thursday | friday | saturday {
        shared actual String string;
        abstract new named(String name) {
            string = name;
        } 
        shared new sunday extends named("SUNDAY") {}
        shared new monday extends named("MONDAY") {}
        shared new tuesday extends named("TUESDAY") {}
        shared new wednesday extends named("WEDNESDAY") {}
        shared new thursday extends named("THURSDAY") {}
        shared new friday extends named("FRIDAY") {}
        shared new saturday extends named("SATURDAY") {}
    }

Now Ceylon will consider a `switch` statement that covers 
all the value constructors as an exhaustive `switch`, and we 
can write:

<!-- try: -->
    Day day = ... ;
    switch (day)
    case (Day.monday | Day.tuesday | 
          Day.wednesday | Day.thursday) { 
        print("need more coffee"); 
    }
    case (Day.friday) { 
        print("thank god"); 
    }
    case (Day.sunday | Day.saturday) { 
        print("we could be having this conversation with beer"); 
    }

The ability to `switch` over value constructors can be 
viewed as an extension of the pre-existing ability to switch
over literal values of types like `Integer`, `Character`,
and `String`.

## A final word

The design I've presented here is the final result of a 
thought process that spanned five years. I personally found
this to be a surprisingly difficult problem to address in a
principled way. For a time, I hoped to not even need to have 
constructors in the language at all. But ultimately I'm very 
happy with the end result. It seems to me not only 
principled and consistent with the rest of the language, but 
also very expressive and powerful.
