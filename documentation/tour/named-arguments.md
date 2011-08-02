---
layout: tour
title: Tour of Ceylon&#58; Named Arguments
tab: documentation
author: Gavin King
---

# #{page.title}

## Named arguments

Consider the following method:

<pre class="brush: ceylon">
    void printf(OutputStream to, String format, Object... values) { 
        ... 
    }
</pre>

(Remember, the last parameter is a sequenced parameter which accepts 
multiple arguments, just like a Java "varargs" parameter.)

We've seen lots of examples of invoking a method or instantiating a class 
using a familiar C-style syntax where arguments are delimited by in parentheses 
and separated by commas. Arguments are matched to parameters by their 
position in the list. Let's see just one more example, just in case:

<pre class="brush: ceylon">
    printf(process, "Thanks, %s. You have been charged %.2f. Your confirmation number is %d.",
            user.name, order.total, order.confimationNumber);
</pre>

This works fine, however Ceylon provides an alternative method 
invocation protocol that is usually easier to read when there are more than 
one or two arguments:

<pre class="brush: ceylon">
    printf {
        to = process;
        format = "Thanks, %s. You have been charged %.2f. Your confirmation number is %d.";
        user.name, order.total, order.confimationNumber
    };
</pre>

This invocation protocol is called a *named argument list*. We can recognize a 
named argument list by the use of braces as delimiters instead of parentheses. 
Notice that arguments are separated by semicolons, except for arguments to the 
sequenced parameter, which are separated by commas. We explicitly specify the 
name of each parameter, except for the sequenced parameter, whose arguments 
always appear at the end of the named parameter list. Note that it's also 
acceptable to call this method like this, passing a sequence to the named 
value parameter:

<pre class="brush: ceylon">
    printf {
        to = process;
        format = "Thanks, %s. You have been charged %.2f. Your confirmation number is %d.";
        values = { user.name, order.total, order.confimationNumber };
    };
</pre>

We usually format named argument invocations across multiple lines.

## Declarative object instantiation syntax

Named arguments are very commonly used for building graphs of objects. 
Therefore, Ceylon provides a special abbreviated syntax that simplifies the 
declaration of an attribute getter, named parameter, or method that builds 
an object by specifying named arguments to the class initializer.

We're allowed to abbreviate an attribute definition of the following form:

<pre class="brush: ceylon">
    Payment payment = Payment {
        method = user.paymentMethod;
        currency = order.currency;
        amount = order.total;
    };
</pre>

or a named argument specification of this form:

<pre class="brush: ceylon">
    payment = Payment {
        method = user.paymentMethod;
        currency = order.currency;
        amount = order.total;
    };
</pre>

to the following more declarative (and less redundant) style:

<pre class="brush: ceylon">
    Payment payment {
        method = user.paymentMethod;
        currency = order.currency;
        amount = order.total;
    }
</pre>

We're even allowed to write a method of the following form:

<pre class="brush: ceylon">
    Payment createPayment(Order order) {
        return Payment {
            method = user.paymentMethod;
            currency = order.currency;
            amount = order.total;
        };
    }
</pre>

using the following abbreviated syntax:

<pre class="brush: ceylon">
    Payment createPayment(Order order) {
        method = user.paymentMethod;
        currency = order.currency;
        amount = order.total;
    }
</pre>

Perhaps you're worried that this looks like a method that assigns the values 
of three attributes of the declaring class, rather than a shortcut syntax for 
a named argument instantiation of the `Payment` class. And that's a very 
fair point. To a Java developer, that is what it looks like. There's two 
things that should alert you to what's really going on. The above method:

* has no return statement, but it's not declared void, and
* contains a list of `=` specification statements instead of `:=` assignment 
  expressions.

Once you're used to Ceylon's more flexible syntax, these differences will 
usually stand out immediately.

## More about named arguments

The following classes define a data structure for building tables:

<pre class="brush: ceylon">
    class Table(String title, Natural rows, Border border, Column... columns) { ... }
    class Column(String heading, Natural width, String content(Natural row)) { ... }
    class Border(Natural padding, Natural weight) { ... }
</pre>

Of course, we could built a `Table` using positional argument lists:

<pre class="brush: ceylon">
    String x(Natural row) { return row.string; }
    String xSquared(Natural row) { return (row**2).string; }
    Table table = Table("Squares", 5, Border(2,1), Column("x",10, x), Column("x**2",12, xSquared));
</pre>

However, it's far more common to use named arguments to build a complex 
graph of objects. In this section we're going to meet some new features of 
named argument lists, that make it especially convenient to build object 
graphs.

First, note that the syntax we've already seen for specifying a named argument 
value looks exactly like the syntax for refining a formal attribute. If you 
think about it, taking into account that a method parameter may accept 
references to other methods, the whole problem of specifying values for named 
parameters starts to look a lot like the problem of refining abstract members. 
Therefore, Ceylon will let us reuse much of the member declaration syntax 
inside a named argument list. (But note that this has not yet been 
implemented in the compiler.)

It's legal to include the following constructs in a named argument list:

* method declarations — specify the "value" of a parameter that accepts a function,
* `object` (anonymous class) declarations — are most useful for specifying 
  the value of a parameter whose type is an interface or abstract class, and
* getter declarations — lets us compute the value of an argument inline.

This helps explain why named argument lists are delimited by braces: the 
fully general syntax for a named argument list is very, very close to the 
syntax for a class, method, or attribute body. Notice, again, how flexibility 
derives from language regularity.

So we could rewrite the code that builds a `Table` as follows:

<pre class="brush: ceylon">
    Table table = Table {
        title="Squares";
        rows=5;
        border = Border {
            padding=2;
            weight=1;
        };
        Column {
            heading="x";
            width=10;
            String content(Natural row) {
                return row.string;
            }
        },
        Column {
            heading="x**2";
            width=12;
            String content(Natural row) {
                return (row**2).string;
            }
        }
    };
</pre>

Notice that we've specified the value of the parameter named content using the 
usual syntax for declaring a method.

Even better, our example can be abbreviated like this:

<pre class="brush: ceylon">
    Table table {
        title="Squares";
        rows=5;
        Border border {
            padding=2;
            weight=1;
        }
        Column {
            heading="x";
            width=10;
            String content(Natural row) {
                return row.string;
            }
        },
        Column {
            heading="x**2";
            width=10;
            String content(Natural row) {
                return (row**2).string;
            }
        }
    }
</pre>

Notice how we've transformed our code from a form which emphasized invocation 
into a form that emphasizes declaration of a hierarchical structure. 
Semantically, the two forms are equivalent. But in terms of readability, 
they are *very different*.

We could put the above totally declarative code in a file by itself and it 
would look like some kind of "mini-language" for defining tables. In fact, 
it's executable Ceylon code that may be validated for syntactic correctness by 
the Ceylon compiler and then compiled to Java bytecode. Even better, the 
Ceylon IDE (when it exists) will provide authoring support for our 
mini-language. In complete contrast to the DSL support in some dynamic 
languages, any Ceylon DSL is completely typesafe! You can think of the 
definition of the `Table`, `Column` and `Border` classes as defining 
the "schema" or "grammar" of the mini-language. (In fact, they are really 
defining the syntax tree for the mini-language.)

Now let's see an example of a named argument list with an inline getter 
declaration:

<pre class="brush: ceylon">
    shared class Payment(PaymentMethod method, Currency currency, Float amount) { ... }
    Payment payment {
        method = user.paymentMethod;
        currency = order.currency;
        Float amount {
            variable Float total := 0.0;
            for (Item item in order.items) {
                total += item.quantity * item.product.unitPrice;
            }
            return total;
        }
    }
</pre>

Finally, here's an example of a named argument list with an inline `object` 
declaration:

<pre class="brush: ceylon">
    shared interface Observable {
        shared void addObserver(Observer&lt;Bottom> observer) { ... }
    }
    shared interface Observer&lt;in Event> {
        shared formal on(Event event);
    }
    observable.addObserver {
        object observer satisfies Observer&lt;UpdateEvent> {
            shared actual void on(UpdateEvent e) {
                writeLine("Update:" + e.string);
            }
        }
    };
</pre>

Note that `Observer<T>` is assignable to `Observer<Bottom>` for any type `T`, 
since `Observer<T>` is contravariant in its type parameter `T`. If this 
doesn't make sense, please read XXX again.

Of course, as we saw in Part 8, a better way to solve this problem might be 
to eliminate the `Observer` interface and pass a method directly:

<pre class="brush: ceylon">
    shared interface Observable {
        shared void addObserver&lt;Event>(void on(Event event)) { ... }
    }
    observable.addObserver {
        void on(UpdateEvent e) {
            writeLine("Update:" + e.string);
        }
    };
</pre>

A quick tangent here: note that we need a type parameter `T` of the 
method `addObserver()` here only because Ceylon inherits Java's limitation 
that function types are nonvariant in their parameter types. This is 
actually pretty unnatural. We should probably eventually come up with a 
workaround to make function types contravariant in their parameter types, 
allowing us to write:

<pre class="brush: ceylon">
    shared interface Observable {
        shared void addObserver(void on(Bottom event)) { ... }
    }
</pre>

## Defining user interfaces

One of the first modules we're going to write for Ceylon will be a library for 
writing HTML templates in Ceylon. A fragment of static HTML would look 
something like this:

<pre class="brush: ceylon">
    Html {
        Head head {
            title = "Hello World";
            cssStyleSheet = 'hello.css';
        }
        Body body {
            Div {
                cssClass = "greeting";
                "Hello World"
            },
            Div {
                cssClass = "footer";
                "Powered by Ceylon"
            }
        }
    }
</pre>

A complete HTML template might look like this:

<pre class="brush: ceylon">
    import ceylon.html { ... }
     
    doc "A web page that displays a greeting"
    page '/hello.html'
    Html hello(Request request) {
         
        Head head {
            title = "Hello World";
            cssStyleSheet = 'hello.css';
        }
         
        Body body {
            Div {
                cssClass = "greeting";
                Hello( request.parameters["name"] ).greeting
            },
            Div {
                cssClass = "footer";
                "Powered by Ceylon"
            }
        }
     
    };
</pre>

## There's more...

There's plenty of potential applications of this syntax aside from user 
interface definition. For example, Ceylon lets us use a named argument list to 
the specify arguments of a program element annotation. But we'll have to come 
back to the subject of annotations in a future installment. 

Now we're going to discuss some of the basic types from the 
[language module](../language-module), in particular numeric types, and introduce 
the idea of operator polymorphism. 

