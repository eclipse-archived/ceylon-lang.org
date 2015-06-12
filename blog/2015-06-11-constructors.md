---
title: Constructors and definite initialization
author: Gavin King
layout: blog
unique_id: blogpage
tab: blog
tags:
---

One of the big new features in Ceylon 1.2 is constructors,
and getting them Just Right has sucked up an amazing chunk
of our time over the past year.

_"Wait, what,"_&mdash;you might be thinking&mdash;_"how 
can Ceylon not have had constructors before now?"_ Well, 
usually, a class has a parameter list, and the body of the
class itself contains procedural logic to initialize the
class.

A classic example Ceylon class is `Point`:

<!-- try: -->
    class Point(x,y) {
        
        shared Float x;
        shared Float y; 
        
        string => "(``x``, ``y``)";
        
    }

We instantiate the class like this:

<!-- try: -->
    Point point = Point(1.0, 3.0);

While designing constructors, we threw the `Point` example
around quite a bit, though we all now consider it to be
pretty contrived. But at least it's good enough to quickly
illustrate the syntax we've settled on:

<!-- try: -->
    class Point {
    
        shared Float x;
        shared Float y; 
        
        shared new cartesian(Float x, Float y) {
            this.x = x;
            this.y = y;
        }
        
        shared new polar(Floar r, Float t) {
            x = r*cos(t);
            y = r*sin(t);
        }
        
        shared new origin extends cartesian(0.0,0.0);
        
        string => "(``x``, ``y``)";
        
    }

This class has three constructors: `cartesian()`, `polar()`,
and `origin`. We can call them like this:

<!-- try: -->
    Point cartesian = Point.cartesian(1.0, 3.0);
    Point polar = Point.polar(1.0, pi/2);
    Point origin = Point.origin;

Alright, with that out of the way, let's move onto a more 
convincing close-to-real-life example, that will help me 
illustrate some unexpected subtleties with constructors in 
Ceylon.

### Initialization and instantiation

The following class is a dumbed-down version of `HashMap`
from the collections module. I'm picking this class because
it's one which:

- illustrates a source of discomfort with initialization in 
  Ceylon, and 
- features a realistic usecase for constructors. 

(Note: I'm going to use the `LinkedList` class here, since 
it makes the code example shorter. That's not what `HashMap`
really uses.)

<!-- try: -->
    //A mapping from string keys to string definitions,  
    //backed by an Array of LinkedLists of entries
    shared class Dictionary(
            initialCapacity = 16, 
            loadFactor = 0.75,
            growthFactor = 2.0,
            entries = {}) 
                satisfies Correspondence<String,String> {
        
        //an alias for the entry type
        shared alias Entry => String->String;
        
        //The initial capacity of the backing array
        Integer initialCapacity;
        //The ratio that triggers a rebuild of the backing 
        //array
        Float loadFactor;
        //The ratio that determines the new capacity of the
        //rebuilt backing array
        Float growthFactor;
        
        //The initial entries of this `Dictionary`
        {Entry*} entries;
        
        //The backing array
        variable value store = 
                Array<LinkedList<Entry>?>
                    .ofSize(initialCapacity, null);
        
        //Calculate an index within the backing array using
        //the hash code of the given key
        function index(String key) => key.hash.and(store.size-1);
        
        //Add or overwrite an entry
        shared void add(String key, String item) {
            value keyIndex = index(key);
            if (exists bucket = store[keyIndex]) {
                bucket.add(key->item);
            }
            else {
                store.set(keyIndex, LinkedList { key->item });
            }
            //rebuild the backing array if necessary
            //...
        }
        
        //populate the backing array with the initial entries
        
        for (key->item in entries) {
            add(key, item);
        }
        
        //implement Correspondence:
        
        get(String key)
            => if (exists bucket = store[index(key)],
                   exists _->item = bucket.find((e) => e.key==key))
               then item else null;
        
        defines(String key) => get(key) exists;
        
    }

Here you can see a mix of member declarations and procedural
logic used for initialization. Parameters used to initialize
the class instance are listed directly after the class name.
Their types, annotations, and documentation may be declared 
immediately in the class parameter list, or, as here, in the
body of the class.

We can instantiate this class by directly invoking the class,
either using positional arguments:

<!-- try: -->
    value dict = Dictionary(10);

Or using named arguments:

<!-- try: -->
    value dict = 
        Dictionary {
            initialCapacity = 3;
            "function" -> "a function or method",
            "value" -> "a value or attribute",
            "new" -> "a constructor"
        };

All this is usually extremely convenient; by not requiring 
a separate constructor declaration, we eliminate the need to 
declare a member of the class twice&mdash;once as a member, 
and once as a constructor parameter. Somewhat more than 95%
of constructors I've written in Java are _pure_ boilerplate,
with nothing interesting to communicate. In such cases we
simply wouldn't use constructors in Ceylon.

### Definite initialization

There's one huge difference between initialization in Ceylon
and what you're used to in other languages like Java. In
Ceylon, the compiler _guarantees_ at compile time that 
every `value` belonging to the class that is either:

- exported via the `shared` annotation, or
- used (_captured_) by other `shared` members of the class

is _definitely initialized_ in the body of the class. There's
nothing like Java's default field values in Ceylon. Why?
Because in Ceylon, most types don't have an obvious default
value&mdash;`null` is not an instance of most types, since
Ceylon's type system guarantees that `NullPointerException`s
can't occur.

### Why we need constructors in Ceylon

_Very_ occasionally, constructors are actually useful. For
quite a long time, I tried to convince myself and others 
that we might not need them at all, but by the time we were
ready to release Ceylon 1.0, even _I_ realized this was
rubbish, and that's why we made sure to reserve the keyword
`new` for future use.

One good example of where we might need a constructor is if
we wanted to add a `clone()` method to `Dictionary`. To 
clone the dictionary by passing its entries to a new 
`Dictionary` would be much more expensive than simply 
copying the structure we already have.

Another example of a class which benefits from constructors
is `Array` itself. Sometimes we instantiate `Array` with a
stream of elements, for example:

<!-- try: -->
    Array { for (i in 0..10) i^3 }

Other times, we instantiate an array with just a given size
and initial element:

<!-- try: -->
    Array.ofSize(1k, 0.0)

The `ofSize()` constructor is _much_ more efficient than
passing a stream of one thousand zeros.

We're about to see what a constructor declarations looks 
like in Ceylon. Keep in mind, that what we said above about
definite initialization still applies! The compiler has to
be able to prove that every constructor of the class 
definitely initializes all the exported or captured `value`s
belonging to the class.

### Default constructors and named constructors

Let's add a `clone()` constructor to `Dictionary`. But first,
let's get this massive caveat off our chests:

> You can't add constructors to a class with a parameter 
> list! Instead, you must first rewrite the class to use
> a "default constructor" for its "normal" initialization
> logic. 

We declare a constructor using `new`. 

- The _default constructor_ is a constructor with no name. 
- Every other constructor of the class must have its own 
  distinct name.

A class isn't required to have a default constructor, but
most classes will have one.

So we need to rewrite `Dictionary` with a default 
constructor and a constructor named `clone()`.

<!-- try: -->
    shared class Dictionary 
            satisfies Correspondence<String,String> {
    
        shared alias Entry => String->String;
        
        Float loadFactor;
        Float growthFactor;             
        {Entry*} initialEntries;

        variable Array<LinkedList<Entry>?> store;
        
        //the default constructor
        shared new (
                Integer initialCapacity = 16, 
                Float loadFactor = 0.75,
                Float growthFactor = 2.0,
                {Entry*} entries = {}) {
            
            this.loadFactor = loadFactor;
            this.growthFactor = growthFactor;
            this.initialEntries = entries;
            
            store = 
                Array<LinkedList<Entry>?>
                    .OfSize(initialCapacity, null);
            
        }
        
        //the clone constructor
        shared new clone(Dictionary dictionary) {
            loadFactor = dictionary.loadFactor;
            growthFactor = dictionary.growthFactor;
            store = 
                Array<LinkedList<Entry>?> {
                    for (bucket in dictionary.store) 
                        bucket?.clone()
                };
            initialEntries = {};
        }
        
        //now that store is definitely initialized, we
        //can define these two important functions
        
        function index(String key) => key.hash.and(store.size-1);
        
        shared void add(String key, String item) {
            value keyIndex = index(key);
            if (exists bucket = store[keyIndex]) {
                bucket.add(key->item);
            }
            else {
                store.set(keyIndex, LinkedList { key->item });
            }
            //rebuild the backing array if necessary
            //...
        }
        
        //finish off initialization by populating the 
        //backing array with the initial entries
        
        for (key->item in initialEntries) {
            add(key, item);
        }
        
        //implement Correspondence:
        //...
        
    }

You might notice something uncomfortable here: doesn't the
`for` loop commented "finish off initialization..." belong 
in the default constructor? Well, here's where we run up 
against the fact that Ceylon is an _extremely_ fussy 
language when it comes to requiring us to prove that any 
value is completely initialized before I use it in an
expression. Since the constructors themselves initialize the
`store`, and since the `add()` and `index()` methods access
the `store`, this `for` loop has to come after the 
declaration of these methods, which themselves have to come
after the constructors.

That's not perfect.

### The definite initialization game

One potential remedy would be to initialize `store` to an
empty `Array`, that we'll immediately throw away in the
constructors, but that will at least let us move the 
definitions of `add()` and `index()` to before the 
constructors: 

<!-- try: -->
    shared class Dictionary 
            satisfies Correspondence<String,String> {
    
        shared alias Entry => String->String;
        
        Float loadFactor;
        Float growthFactor;             

        //initialize the store to an empty array, just to
        //satisfy definite initialization checks
        variable value store = Array<LinkedList<Entry>?> {};
        
        //utility functions, now defined before the 
        //constructors:
        
        function index(String key) => key.hash.and(store.size-1);
        
        shared void add(String key, String item) {
            value keyIndex = index(key);
            if (exists bucket = store[keyIndex]) {
                bucket.add(key->item);
            }
            else {
                store.set(keyIndex, LinkedList { key->item });
            }
            //rebuild the backing array if necessary
            //...
        }
                
        shared new (
                Integer initialCapacity = 16, 
                Float loadFactor = 0.75,
                Float growthFactor = 2.0,
                {Entry*} entries = {}) {
            
            this.loadFactor = loadFactor;
            this.growthFactor = growthFactor;
            
            store = 
                Array<LinkedList<Entry>?>
                    .ofSize(initialCapacity, null);
            
            //this, right where it belongs!
            for (key->item in entries) {
                add(key, item);
            }
        }
        
        shared new clone(Dictionary dictionary) {
            loadFactor = dictionary.loadFactor;
            growthFactor = dictionary.growthFactor;
            store = 
                Array<LinkedList<Entry>?> {
                    for (bucket in dictionary.store) 
                        bucket?.clone()
                };
        }
        
        //implement Correspondence:
        //...
        
    }

That's an improvement, I think. In classes with interesting
initialization logic, it's not _that_ uncommon to need to
play this 
prove-to-me-that-you-really-initialized-it-before-you-used-it 
game with the typechecker. That's the cost of never experiencing 
a `NullPointException`.

But if that solution left you dissatisfied, there's a second
approach we could take. And this is what I would do in 
practice. We can refactor the code so that `index()` and
`add()` accept the `store` as an argument:

<!-- try: -->
    shared class Dictionary 
            satisfies Correspondence<String,String> {
    
        shared alias Entry => String->String;
        
        //let's define a new type alias!
        alias Store => Array<LinkedList<Entry>?>;
        
        Float loadFactor;
        Float growthFactor;             

        variable Store store;
        
        //utility functions taking store as a parameter
        //because they're called before store is definitely
        //initialized
        
        function index(String key, Store store) 
                => key.hash.and(store.size-1);
        
        void addToStore(Entry entry, Store store) {
            value keyIndex = index(entry.key, store);
            if (exists bucket = store[keyIndex]) {
                bucket.add(entry);
            }
            else {
                store.set(keyIndex, LinkedList { entry });
            }
            //rebuild the backing array if necessary
            //...
        }
                
        shared new (
                Integer initialCapacity = 16, 
                Float loadFactor = 0.75,
                Float growthFactor = 2.0,
                {Entry*} entries = {}) {
            
            this.loadFactor = loadFactor;
            this.growthFactor = growthFactor;
            
            store = 
                Array<LinkedList<Entry>?>
                    .ofSize(initialCapacity, null);
            
            for (entry in entries) {
                addToStore(entry, store);
            }
        }
        
        shared new clone(Dictionary dictionary) {
            loadFactor = dictionary.loadFactor;
            growthFactor = dictionary.growthFactor;
            store = 
                Array<LinkedList<Entry>?> {
                    for (bucket in dictionary.store) 
                        bucket?.clone()
                };
        }
        
        shared void add(String key, String item)
                => addToStore(key->item, store);
        
        //implement Correspondence:
        //...
        
    }

We've one more trick up our sleeves.

### Constructor delegation and partial constructors

It's not uncommon for constructors to share some common
initialization logic, and we would like to have a way to
define that logic in one place and share it between our
constructors. One way, as we can see above, is to just write
it directly in the body of the class. A second technique is
to use a _partial constructor_. Unlike the constructors 
we've already seen, a partial constructor is _not_ required
to definitely initialize all the exported and captured 
`value`s belonging to a class. On the other hand, you're not
allowed to instantiate a class by calling a partial 
constructor! What you can do is have a constructor _delegate_
to the partial constructor.

A partial constructor is annotated `abstract`. Constructor 
delegation is written using `extends`. Partial constructors
must be defined before the constructors that delegate to 
them.

<!-- try: -->
    shared class Dictionary 
            satisfies Correspondence<String,String> {
        
        shared alias Entry => String->String;
        alias Store => Array<LinkedList<Entry>?>;
        
        Float loadFactor;
        Float growthFactor;             

        variable Store store;
        
        function index(String key, Store store) 
                => key.hash.and(store.size-1);
        
        void addToStore(Entry entry, Store store) {
            value keyIndex = index(entry.key, store);
            if (exists bucket = store[keyIndex]) {
                bucket.add(entry);
            }
            else {
                store.set(keyIndex, LinkedList { entry });
            }
            //rebuild the backing array if necessary
            //...
        }
        
        //a partial constructor
        abstract new init(Float loadFactor, Float growthFactor) {
            this.loadFactor = loadFactor;
            this.growthFactor = growthFactor;
        }
        
        shared new (
            Integer initialCapacity = 16, 
            Float loadFactor = 0.75,
            Float growthFactor = 2.0,
            {Entry*} entries = {}) 
                //delegate to the partial constructor
                extends init(loadFactor, growthFactor) {
            
            store = 
                    Array<LinkedList<Entry>?>
                        .ofSize(initialCapacity, null);
            
            for (entry in entries) {
                addToStore(entry, store);
            }
        }
        
        shared new clone(Dictionary dictionary)
                //delegate to the partial constructor
                extends init(dictionary.loadFactor, 
                             dictionary.growthFactor) {
            store = 
                    Array<LinkedList<Entry>?> {
                        for (bucket in dictionary.store) 
                            bucket?.clone()
                    };
        }
        
        shared void add(String key, String item)
                => addToStore(key->item, store);
        
        //implement Correspondence:
        //...
        
    }


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
        shared new () {
            print(4);
        }
        print(5);
        shared new create() {
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

### Value constructors

The constructors we've seen so far are more precisely
_callable constructors_. Ceylon also has _value constructors_.
A value constructor for a toplevel class is a singleton 
instance of the class with its own initialization logic.

For example, a `Locale` class might have a value constructor
for the default locale:

<!-- try: -->
    class Locale {
        
        shared String tag;
        
        shared new (String tag) { 
            this.tag = tag;
        }
        
        shared new default {
            tag = system.locale;
        }
        
        ...
        
    }
 
 OK, so that's a little contrived, but you get the idea!
 
 We can access the singleton default locale like this:
 
<!-- try: -->
     Locale defaultLocate = Locale.default;

Value constructors can delegate to other constructors, but
may not themselves be delegated to. There are no partial
value constructors.
