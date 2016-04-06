---
title: Object construction and validation
author: Gavin King
layout: blog
unique_id: blogpage
tab: blog
tags: []
---

When porting Java code to Ceylon, I sometimes run into
Java classes where the constructor mixes _validation_ with
_initialization_. Let's illustrate what I mean with a simple
but very contrived example.

## Some bad code

Consider this Java class. (Try not to write code like this
at home, kiddies!)

<!-- try: -->
<!-- lang: java -->
    
    public class Period {
        
        private final Date startDate;
        private final Date endDate;
        
        //returns null if the given String
        //does not represent a valid Date
        private Date parseDate(String date) {
           ...
        }
        
        public Period(String start, String end) {
            startDate = parseDate(start);
            endDate = parseDate(end);
        }
        
        public boolean isValid() {
            return startDate!=null && endDate!=null;
        }
        
        public Date getStartDate() {
            if (startDate==null) 
                throw new IllegalStateException();
            return startDate;
        }
    
        public Date getEndDate() {
            if (endDate==null)
                throw new IllegalStateException();
            return endDate;
        }
    } 

Hey, I warned you it was going to be contrived. But it's 
really not uncommon to find stuff like this in real Java 
code.

The problem here is that even if validation of the input 
parameters (in the elided `parseDate()` method) fails, we
still receive an instance of `Period`. But the `Period` we
get isn't actually in a "valid" state. What do I mean by 
that, precisely?

Well, I would say that an object is in an invalid state if
it can't respond meaningfully to its public operations. In
this case, `getStartDate()` and `getEndDate()` can throw an
`IllegalStateException`, which is a condition I would 
consider not "meaningful".

Another way to look at this is that what we have here is a
failure of type safety in the design of `Period`. Unchecked 
exceptions represent a "hole" in the type system. So a more
typesafe design for `Period` would be one which never uses
unchecked exceptions&mdash;that doesn't throw
`IllegalStateException`, in this case.

(Actually, in practice, in real code, I'm more likely to 
encounter a `getStartDate()` which _doesn't_ check for 
`null`, and actually results in a `NullPointerException`
further down the line, which is even worse.)

We can easily translate the above `Period` class to Ceylon:

<!-- try: -->
    shared class Period(String start, String end) {
        
        //returns null if the given String
        //does not represent a valid Date
        Date? parseDate(String date) => ... ;
        
        value maybeStartDate = parseDate(start);
        value maybeEndDate = parseDate(end);
        
        shared Boolean valid
            => maybeStartDate exists 
            && maybeEndDate exists;
        
        shared Date startDate {
            assert (exists maybeStartDate);
            return maybeStartDate;
        }
    
        shared Date endDate {
            assert (exists maybeEndDate);
            return maybeEndDate;
        }
    } 

And, of course, this code suffers from the same problem as
the original Java code. The two `assert`ions are screaming 
at us that there is a problem with the typesafety of the
code.

## Making the Java code better

How could we improve this code in Java. Well, here's a case
where Java's much-maligned checked exceptions would be a 
really reasonable solution! We could slightly change `Period`
to throw a checked exception from its constructor:

<!-- try: -->
<!-- lang: java -->
    
    public class Period {
        
        private final Date startDate;
        private final Date endDate;
        
        //throws if the given String
        //does not represent a valid Date
        private Date parseDate(String date)
                throws DateFormatException {
           ...
        }
        
        public Period(String start, String end) 
                throws DateFormatException {
            startDate = parseDate(start);
            endDate = parseDate(end);
        }
        
        public Date getStartDate() {
            return startDate;
        }
    
        public Date getEndDate() {
            return endDate;
        }
    } 

Now, with this solution, we can never get a `Period` in an
invalid state, and the code which instantiates `Period` is
obligated by the compiler to handle the case of invalid 
input by `catch`ing the `DateFormatException` somewhere.

<!-- try: -->
<!-- lang: java -->
    try {
        Period p = new Period(start, end);
        ...
    }
    catch (DateFormatException dfe) {
        ...
    }

This is a good and excellent and righteous use of checked
exceptions, and it's unfortunate that I only rarely find 
Java code which uses checked exceptions like this.

### Making the Ceylon code better

What about Ceylon? Ceylon doesn't have checked exceptions, 
so we'll have to look for a different solution. Typically,
in cases where Java would call for use of a function that
throws a checked exception, Ceylon would call for the use
of a function that returns a union type. Since the 
initializer of a class can't return any type other than the
class itself, we'll need to extract some of the mixed
initialization/validation logic into a factory function.
    
<!-- try: -->
    //returns DateFormatError if the given 
    //String does not represent a valid Date
    Date|DateFormatError parseDate(String date) => ... ;
    
    shared Period|DateFormatError parsePeriod
            (String start, String end) {
        value startDate = parseDate(start);
        if (is DateFormatError startDate) {
            return startDate;
        }
        value endDate = parseDate(end);
        if (is DateFormatError endDate)  {
            return endDate;
        }
        return Period(startDate, endDate);
    }
    
    shared class Period(startDate, endDate) {
        shared Date startDate;
        shared Date endDate;
    } 

<!--
    shared Period|DateFormatError parsePeriod
            (String start, String end)
        => let (startDate = parseDate(start),
                endDate = parseDate(end))
                if (is DateFormatError startDate) 
                    then startDate
           else if (is DateFormatError endDate) 
                    then endDate
           else Period(startDate, endDate);
-->
The caller is forced by the type system to deal with 
`DateFormatError`:

<!-- try: -->
    value p = parsePeriod(start, end);
    if (is DateFormatError p) {
        ...
    }
    else {
        ...
    }

Or, if we didn't care about the actual problem with the 
given date format (probable, given that the initial code we
were working from lost that information), we could just use
`Null` instead of `DateFormatError`:

<!-- try: -->
    //returns null if the given String 
    //does not represent a valid Date
    Date? parseDate(String date) => ... ;
    
    shared Period? parsePeriod(String start, String end)
        => if (exists startDate = parseDate(start), 
               exists endDate = parseDate(end))
           then Period(startDate, endDate)
           else null;
    
    shared class Period(startDate, endDate) {
        shared Date startDate;
        shared Date endDate;
    } 

At least arguably, the approach of using a factory function 
is superior, since in general it obtains better separation
between validation logic and object initialization. This is
especially useful in Ceylon, where the compiler enforces 
some quite heavy-handed restrictions on object 
initialization logic in order to guarantee that all fields 
of the object are assigned exactly once.

## Summary

In conclusion:

- Try to separate validation from initialization, wherever
  reasonable.
- Validation logic doesn't usually belong in constructors 
  (especially not in Ceylon).
- Don't create objects in "invalid" states.
- An "invalid" state can sometimes be detected by looking 
  for failures of typesafety.
- In Java, a constructor or factory function that throws a 
  checked exception is a reasonable alternative.
- In Ceylon, a factory function that returns a union type is
  a reasonable alternative.
