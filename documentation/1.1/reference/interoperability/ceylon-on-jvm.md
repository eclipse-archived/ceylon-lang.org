---
layout: reference11
title_md: Starting a Ceylon module from the JVM
tab: documentation
unique_id: docspage
author: Stef Epardaud
---

# #{page.title_md}

## Description

If you use the `ceylon run` command-line, or `Run as > Ceylon Application` from the Ceylon IDE,
your module will run on JBoss Modules, which guarantees that each module will have an isolated
class loader (this allows you to have multiple versions of the same module loaded at run time
without problem) and the Ceylon metamodel will be automatically set up.

If you want to invoke Ceylon from your Java program without JBoss Modules, then there are two
options available to you:

- The [`Main` API](#using_the_main_api) to run Ceylon modules from the Java command line or a 
  Java class with a flat class path, or
- The [`CeylonToolProvider` API](#using_the_ceylontoolprovider_api) to compile and run Ceylon
  modules for both Java and JavaScript backends.

## Note about the metamodel system

Ceylon provides a run-time accessible metamodel, which provides information about the existing
modules, packages and types, and is used by reified generics. Java also has a run-time metamodel
called _reflection_, but it is automatically set up by the JVM. Since Ceylon does not have its
own VM, the metamodel has to be set up externally. This is automatic when using JBoss Modules,
but has to be done manually otherwise.

In the future, we hope to be able to make this set up automatic.

## Using the `Main` API

This is an API provided by the `ceylon.language` module in the `com.redhat.ceylon.compiler.java.runtime.Main`
class. There are two modes of operation: calling it from the `java` command-line to start Ceylon
modules without JBoss Modules, or calling it from Java source code.

Both modes require you to put all the required Ceylon module dependencies of the module you want to run in
the classpath, manually. However, the `ceylon classpath` command will give you the classpath required.

For example, suppose you want to run the `ceylon.formatter` module from Java, then you will need all its
transitive dependencies loaded in the JVM, so you run `ceylon classpath ceylon.formatter`:

<!-- lang:shell -->
    $ ceylon classpath ceylon.formatter/1.1.0
    /usr/share/ceylon/1.1.0/repo/org/apache/httpcomponents/httpclient/4.3.2/org.apache.httpcomponents.httpclient-4.3.2.jar:/home/stephane/.ceylon/repo/ceylon/test/1.1.0/ceylon.test-1.1.0.car:/usr/share/ceylon/1.1.0/repo/org/apache/httpcomponents/httpcore/4.3.2/org.apache.httpcomponents.httpcore-4.3.2.jar:/usr/share/ceylon/1.1.0/repo/com/redhat/ceylon/common/1.1.0/com.redhat.ceylon.common-1.1.0.jar:/usr/share/ceylon/1.1.0/repo/com/redhat/ceylon/compiler/java/1.1.0/com.redhat.ceylon.compiler.java-1.1.0.jar:/usr/share/ceylon/1.1.0/repo/org/antlr/antlr/2.7.7/org.antlr.antlr-2.7.7.jar:/usr/share/ceylon/1.1.0/repo/com/github/lookfirst/sardine/5.1/com.github.lookfirst.sardine-5.1.jar:/usr/share/ceylon/1.1.0/repo/org/apache/commons/logging/1.1.1/org.apache.commons.logging-1.1.1.jar:/usr/share/ceylon/1.1.0/repo/com/github/rjeschke/txtmark/0.11/com.github.rjeschke.txtmark-0.11.jar:/usr/share/ceylon/1.1.0/repo/ceylon/language/1.1.0/ceylon.language-1.1.0.car:/usr/share/ceylon/1.1.0/repo/org/slf4j/api/1.6.1/org.slf4j.api-1.6.1.jar:/usr/share/ceylon/1.1.0/repo/net/minidev/json-smart/1.1.1/net.minidev.json-smart-1.1.1.jar:/usr/share/ceylon/1.1.0/repo/org/antlr/stringtemplate/3.2.1/org.antlr.stringtemplate-3.2.1.jar:/home/stephane/.ceylon/repo/ceylon/collection/1.1.0/ceylon.collection-1.1.0.car:/home/stephane/.ceylon/repo/ceylon/formatter/1.1.0/ceylon.formatter-1.1.0.car:/usr/share/ceylon/1.1.0/repo/org/antlr/runtime/3.4/org.antlr.runtime-3.4.jar:/usr/share/ceylon/1.1.0/repo/org/jboss/modules/1.3.3.Final/org.jboss.modules-1.3.3.Final.jar:/usr/share/ceylon/1.1.0/repo/com/redhat/ceylon/compiler/js/1.1.0/com.redhat.ceylon.compiler.js-1.1.0.jar:/home/stephane/.ceylon/repo/ceylon/file/1.1.0/ceylon.file-1.1.0.car:/home/stephane/.ceylon/repo/ceylon/interop/java/1.1.0/ceylon.interop.java-1.1.0.car:/usr/share/ceylon/1.1.0/repo/com/redhat/ceylon/maven-support/2.0/com.redhat.ceylon.maven-support-2.0.jar:/usr/share/ceylon/1.1.0/repo/com/redhat/ceylon/module-resolver/1.1.0/com.redhat.ceylon.module-resolver-1.1.0.jar:/usr/share/ceylon/1.1.0/repo/com/redhat/ceylon/typechecker/1.1.0/com.redhat.ceylon.typechecker-1.1.0.jar:/usr/share/ceylon/1.1.0/repo/org/tautua/markdownpapers/core/1.2.7/org.tautua.markdownpapers.core-1.2.7.jar:/usr/share/ceylon/1.1.0/repo/org/apache/commons/codec/1.8/org.apache.commons.codec-1.8.jar:/usr/share/ceylon/1.1.0/repo/org/jboss/jandex/1.0.3.Final/org.jboss.jandex-1.0.3.Final.jar

It is a mouthful, to be sure, and we plan on removing most of those runtime dependencies in the next release, but
it does the job.

Of course, you can directly pass this classpath to Java:

<!-- lang:shell -->
    $ java -cp `ceylon classpath ceylon.formatter/1.1.0` ...

### Running Ceylon modules directly from the command-line using `java`

You can use the `com.redhat.ceylon.compiler.java.runtime.Main` as the Java main class to execute your
Ceylon modules. For this, you just need to set up the classpath as we’ve already seen, and specify the
module you want to run, its main Java class and any arguments you want to pass it:

<!-- lang:shell -->
    $ java -cp `ceylon classpath ceylon.formatter/1.1.0` com.redhat.ceylon.compiler.java.runtime.Main ceylon.formatter/1.1.0 ceylon.formatter.run_ args...

This will set up the metamodel and invoke the `ceylon.formatter` module in a flat classpath.

### Running Ceylon modules from Java code using the `Main` API

Similarly, you can achieve the same using the API in `Main` if you already set up your classpath manually,
this will set up the metamodel and invoke the `ceylon.formatter` module:

<!-- lang:java -->
    import com.redhat.ceylon.compiler.java.runtime.Main;
    
    public class Run {
        public static void main(String[] args){
            Main.runModule("ceylon.formatter", "1.1.0", "ceylon.formatter.run_");
        }
    }

## Using the `CeylonToolProvider` API

The `com.redhat.ceylon.compiler.java.runtime.tools.CeylonToolProvider` class from the `ceylon.language` module
allows you to compile and run Ceylon modules from the JVM for both the JVM and JS backends.

This API assumes you have the Ceylon distribution in your classpath, but not necessarily the Ceylon modules you
want to compile or run (although it is supported too). This means you have to start your JVM with a classpath
set to `ceylon classpath ceylon.language/1.1.0` or a similar classpath provided by a manually created `ClassLoader`.

### Compiling a Ceylon module for both backends

<!-- lang:java -->
    import com.redhat.ceylon.compiler.java.runtime.tools.*;
    import java.io.File;
    
    public class Run {
        public static void main(String[] args){
            CompilerOptions options = new CompilerOptions();
            options.addModule("com.example");
            
            CompilationListener listener = new CompilationListener(){
                @Override
                public void error(File file, long line, long column, String message){}
                @Override
                public void warning(File file, long line, long column, String message){}
                @Override
                public void moduleCompiled(String module, String version){}
            };
            
            Compiler jvmCompiler = CeylonToolProvider.getCompiler(Backend.Java);
            jvmCompiler.compile(options, listener);
            
            Compiler jsCompiler = CeylonToolProvider.getCompiler(Backend.JavaScript);
            jsCompiler.compile(options, listener);
        }
    }

### Running a Ceylon module for both backends

This will run the given Ceylon modules in the current JVM for the Java backend, or in a new `node.js` process
for the JavaScript backend.

For the Java backend, this will set up a new `ClassLoader` which knows how to load all the dependencies of the
module you want to run. Again, assuming the `ceylon.language` module and its dependencies are already in your
classpath.

<!-- lang:java -->
    import com.redhat.ceylon.compiler.java.runtime.tools.*;
    
    public class Run {
        public static void main(String[] args){
            RunnerOptions options = new RunnerOptions();
            String module = "com.example";
            String version = "1";
            
            Runner jvmRunner = CeylonToolProvider.getRunner(Backend.Java, options, module, version);
            try{
                jvmRunner.run();
            }finally{
                // make sure we release the classloader
                jvmRunner.cleanup();
            }
            
            Runner jsRunner = CeylonToolProvider.getRunner(Backend.JavaScript, options, module, version);
            try{
                jsRunner.run();
            }finally{
                // make sure we release resources
                jsRunner.cleanup();
            }
        }
    }

### Flat repositories

Ceylon’s notion of [module repositories](../../repository) is usually hierarchical, but sometimes you will have jars in your
classpath which are all in a flat folder, and if you want to make them accessible to Ceylon modules you can
then specify a _flat repository_ to the Ceylon tools so that they _see_ the modules which are in your classpath.

Supposing you have all the jars from the `project/lib` folder in your classpath, and you want to tell Ceylon
to use it as a flat repository, you can do so like this:

<!-- lang:java -->
    import com.redhat.ceylon.compiler.java.runtime.tools.*;
    import java.io.File;
    
    public class Run {
        public static void main(String[] args){
            String module = "com.example";
            String repo = "project/lib";

            CompilerOptions options = new CompilerOptions();
            options.addModule("com.example");
            options.addUserRepository("flat:"+repo);
            
            CompilationListener listener = new CompilationListener(){
                @Override
                public void error(File file, long line, long column, String message){}
                @Override
                public void warning(File file, long line, long column, String message){}
                @Override
                public void moduleCompiled(String module, String version){}
            };
            
            Compiler jvmCompiler = CeylonToolProvider.getCompiler(Backend.Java);
            jvmCompiler.compile(options, listener);
            
            // now run it
            RunnerOptions runOptions = new RunnerOptions();
            runOptions.addUserRepository("flat:"+repo);
            String version = "1";
            
            Runner jvmRunner = CeylonToolProvider.getRunner(Backend.Java, runOptions, module, version);
            try{
                jvmRunner.run();
            }finally{
                // make sure we release the classloader
                jvmRunner.cleanup();
            }
        }
    }

Ceylon will be able to use `project/lib` to look up modules, in the form of `module.name-version.jar`,
and will use any of the following files to find the module dependencies:

- `module.name-version.xml` in the same folder, or
- `META-INF/jbossmodules/module/name/version/module.xml` in the jar, or
- `META-INF/jbossmodules/module/name/version/module.properties` in the jar, or
- `META-INF/MANIFEST.MF` for OSGi modules in the jar, or
- `META-INF/maven/module/name/pom.xml` for Maven modules in the jar.
