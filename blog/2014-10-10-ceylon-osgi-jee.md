Write in Ceylon, Deploy in OSGI, Use in JEE
===========================================

_... or How to push Ceylon inside J2EE applications_


The Ceylon language is _inherently modular_, and is shipped with a _complete infrastructure_ that allows leveraging this modularity out-of-the box.

However Ceylon is _not captive of its own infrastructure_ : After the Java and JS interoperability efforts, the 1.1.0 version has brought out-of-the-box compatibility with OSGI.

Instead of writing long explanations, I thought it would be better to provide some examples of what can be done, that anyone can try. You will find the first one here :

https://github.com/davidfestal/Ceylon-Osgi-Examples/

In this first example, I intentionally show the use of a Ceylon module totally outside Ceylon's standard infrastructure, even totally outside the JBoss world : Ceylon code is used by a Web application servlet running on a Glassfish v4.1 application server. But of course it can be use din other OSGI-enabled application servers or containers.

In the next examples we will try to go further :  providing services, using Ceylon annotations (compatible with Java annotations), etc ...

Please report any problem you might encounter while testing, and feel free to submit pull request for other successful use cases  you might have built.

Looking forward for your remarks, ... and for the time to write the following examples.
