---
layout: tour
title: Tour of Ceylon&#58; Named Arguments
tab: documentation
author: Gavin King
---

# #{page.title}

This is the eleventh leg in the Tour of Ceylon. In the 
[previous leg](../functions) we learnt about functions. This part builds on 
that by covering Ceylon's support for calling functions using 
*named arguments*.


## Named arguments

Consider the following method:

    void printf(OutputStream to, String format, Object... values) { 
        ... 
    }

Remember, the last parameter is a [sequenced parameter](../missing-pieces#sequenced_parameters) which accepts 
multiple arguments, just like a Java "varargs" parameter.)

We've seen lots of examples of invoking a method or instantiating a class 
using a familiar C-style syntax where arguments are delimited by parentheses 
and separated by commas. Arguments are matched to parameters by their 
position in the list. Let's see one more example, just in case:

    printf(process, "Thanks, %s. You have been charged %.2f. 
                     Your confirmation number is %d.",
            user.name, order.total, order.confimationNumber);

This works fine, however Ceylon provides an alternative method 
invocation protocol that is usually easier to read when there are more than 
one or two arguments:

    printf {
        to = process;
        format = "Thanks, %s. You have been charged %.2f. 
                  Your confirmation number is %d.";
        user.name, order.total, order.confimationNumber
    };

This invocation protocol is called a *named argument list*. We can recognize a 
named argument list by the use of braces as delimiters instead of parentheses. 
Notice that arguments are separated by semicolons, except for arguments to the 
sequenced parameter, which are separated by commas. We explicitly specify the 
name of each parameter, except for the sequenced parameter, whose arguments 
always appear at the end of the named parameter list. Note that it's also 
acceptable to call this method like this, passing a sequence to the named 
value parameter:

    printf {
        to = process;
        format = "Thanks, %s. You have been charged %.2f. 
                  Your confirmation number is %d.";
        values = { user.name, order.total, order.confimationNumber };
    };

We usually format named argument invocations across multiple lines.


## Declarative object instantiation syntax

Named arguments are very commonly used for building graphs of objects. 
Therefore, Ceylon provides a special abbreviated syntax that simplifies the 
declaration of an attribute getter, named parameter, or method that builds 
an object by specifying named arguments to the class initializer. 
You've actually [already encountered](../modules#module_descriptors) this 
abbreviated syntax, though you probably didn't know it.

We're allowed to abbreviate an attribute definition of the following form:

    Payment payment = Payment {
        method = user.paymentMethod;
        currency = order.currency;
        amount = order.total;
    };

or a named argument specification of this form:

    payment = Payment {
        method = user.paymentMethod;
        currency = order.currency;
        amount = order.total;
    };

to the following more declarative (and less redundant) style:

    Payment payment {
        method = user.paymentMethod;
        currency = order.currency;
        amount = order.total;
    }

We're even allowed to write a method of the following form:

    Payment createPayment(Order order) {
        return Payment {
            method = user.paymentMethod;
            currency = order.currency;
            amount = order.total;
        };
    }

using the following abbreviated syntax:

    Payment createPayment(Order order) {
        method = user.paymentMethod;
        currency = order.currency;
        amount = order.total;
    }

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

    class Table(String title, Natural rows, Border border, Column... columns) { ... }
    class Column(String heading, Natural width, String content(Natural row)) { ... }
    class Border(Natural padding, Natural weight) { ... }

Of course, we could built a `Table` using positional argument lists:

    String x(Natural row) { return row.string; }
    String xSquared(Natural row) { return (row**2).string; }
    Table table = Table("Squares", 5, Border(2,1), Column("x",10, x), Column("x**2",12, xSquared));

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

Notice that we've specified the value of the parameter named `content` using the 
usual syntax for declaring a method.

Even better, our example can be abbreviated like this:

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

Notice how we've transformed our code from a form which emphasized invocation 
into a form that emphasizes declaration of a hierarchical structure. 
Semantically, the two forms are equivalent. But in terms of readability, 
they are *very different*.

We could put the above totally declarative code in a file by itself and it 
would look like some kind of "mini-language" for defining tables. In fact, 
it's executable Ceylon code that may be validated for syntactic correctness by 
the Ceylon compiler and then compiled to Java bytecode. Even better, the 
Ceylon IDE will provide authoring support for our 
mini-language. In complete contrast to the DSL support in some dynamic 
languages, any Ceylon DSL is completely typesafe! You can think of the 
definition of the `Table`, `Column` and `Border` classes as defining 
the "schema" or "grammar" of the mini-language. (In fact, they are really 
defining the syntax tree for the mini-language.)

Now let's see an example of a named argument list with an inline getter 
declaration:

    shared class Payment(PaymentMethod method, Currency currency, Float amount) { ... }
    Payment payment {
        method = user.paymentMethod;
        currency = order.currency;
        Float amount {
            variable Float total := 0.0;
            for (item in order.items) {
                total += item.quantity * item.product.unitPrice;
            }
            return total;
        }
    }

Finally, here's an example of a named argument list with an inline `object` 
declaration:

    shared interface Observable {
        shared void addObserver(Observer<Bottom> observer) { ... }
    }
    shared interface Observer<in Event> {
        shared formal on(Event event);
    }
    observable.addObserver {
        object observer satisfies Observer<UpdateEvent> {
            shared actual void on(UpdateEvent e) {
                print("Update:" + e.string);
            }
        }
    };

Note that `Observer<T>` is assignable to `Observer<Bottom>` for any type `T`, 
since `Observer<T>` is contravariant in its type parameter `T`. If this 
doesn't make sense, please read the section on [generics](../generics) again.

Of course, as we saw in the leg on [functions](../functions), 
a better way to solve this problem might be 
to eliminate the `Observer` interface and pass a method directly:

    shared interface Observable {
        shared void addObserver<Event>(void on(Event event)) { ... }
    }
    observable.addObserver {
        void on(UpdateEvent e) {
            print("Update:" + e.string);
        }
    };


## Defining user interfaces

One of the first modules we're going to write for Ceylon will be a library for 
writing HTML templates in Ceylon. A fragment of static HTML would look 
something like this:

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

A complete HTML template might look like this:

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

## There's more...

There's plenty of potential applications of this syntax aside from user 
interface definition. For example, Ceylon lets us use a named argument list to 
specify the arguments of a program element annotation. But we'll have to come 
back to the subject of [annotations](../annotations) in a future installment. 

Now we're going to discuss some of the basic types from the 
[language module](../language-module), in particular numeric types, and introduce 
the idea of operator polymorphism. 

