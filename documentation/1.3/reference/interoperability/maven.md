---
layout: reference13
title_md: Building with Maven
tab: documentation
unique_id: docspage
author: Stef Epardaud
---

# #{page.title_md}

You can build your Ceylon modules with Maven if you want. This is most useful if you have a mix
of Java and Ceylon modules in your project, which depend on one another. Everything works out of
the box and the Ceylon and Java projects play together well.

## Configuring Maven for a Ceylon module

You can use the [Maven Ceylon plugin](https://github.com/ceylon/ceylon-maven-plugin/) by adding these
lines to your `pom.xml`:

<!-- try: -->
<!-- lang:xml -->
    <build>
      <plugins>
        <plugin>
          <groupId>org.ceylon-lang</groupId>
          <artifactId>ceylon-maven-plugin</artifactId>
          <version>1.3.2</version>
          <configuration>
            <!-- 
             This is required if you intend to have Java modules that depend
             on this Ceylon module, or if you want to publish your Ceylon module
             using Maven.
            -->
            <explode>true</explode>
          </configuration>
          <!-- This plugs the Ceylon plugin into the compile, compileTest, test phases -->
          <extensions>true</extensions>
        </plugin>
      </plugins>
    </build>

The Maven Ceylon plugin will hook into your regular Maven lifecycles to compile modules, tests
and run tests.

Just place your Ceylon module in the `src/main/ceylon` source folder, but make sure that the
module coordinates defined in the `pom.xml` and the `module.ceylon` match. For example, if you
define your Ceylon module as `com.foo.bar` then your `groupId` should be `com.foo` and your
`artifactId` should be `bar`. If you want to customize your Maven coordinates you can do it too:

<!-- try: -->
    module com.foo.bar
     maven:"my-group:my-artifact" 
     "1.2"{} 

Note that you can only define a single Ceylon module per Maven module if you intend to publish
the module using Maven. The plugin supports defining more than one Ceylon module per Maven module
but that is not the recommended workflow.

## Dependencies

All dependencies declared in the Ceylon module descriptor should be present in the `pom.xml` as well,
because Maven will use the `pom.xml` when publishing the module to Maven repositories and so the `compile`
phase of the plugin will check that they are equal.

The implicit `ceylon.language` dependency also has to be explicitly declared in your `pom.xml`. 

For example, the following Ceylon module:

<!-- try: -->
    module com.foo.bar
     maven:"my-group:my-artifact" 
     "1.2"{
     import ceylon.collection "1.3.2";
    } 

Should be declared like this in your `pom.xml`:

<!-- try: -->
<!-- lang:xml -->
    <project xmlns="http://maven.apache.org/POM/4.0.0" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
      xsi:schemaLocation="http://maven.apache.org/POM/4.0.0 http://maven.apache.org/maven-v4_0_0.xsd">
      <modelVersion>4.0.0</modelVersion>
      <groupId>my-group</groupId>
      <artifactId>my-artifact</artifactId>
      <version>1.2</version>
      <packaging>jar</packaging>
      <name>my-artifact</name>
      <dependencies>
        <dependency>
          <groupId>org.ceylon-lang</groupId>
          <artifactId>ceylon.collection</artifactId>
          <version>1.3.2</version>
        </dependency>
        <dependency>
          <groupId>org.ceylon-lang</groupId>
          <artifactId>ceylon.language</artifactId>
          <version>1.3.2</version>
        </dependency>
      </dependencies>
      <build>
        <plugins>
          <plugin>
            <groupId>org.ceylon-lang</groupId>
            <artifactId>ceylon-maven-plugin</artifactId>
            <version>1.3.2</version>
            <configuration>
              <explode>true</explode>
            </configuration>
            <extensions>true</extensions>
          </plugin>
        </plugins>
      </build>
    </project>

## Inter-project dependencies

To make your Ceylon module depend on another Maven module, simply declare the
dependency in your `pom.xml` as you would normally, and in the `module.ceylon`
descriptor as a regular dependency:

<!-- try: -->
<!-- lang:xml -->
    <dependency>
      <groupId>my-group</groupId>
      <artifactId>other-module</artifactId>
      <version>1.2</version>
    </dependency>

And:

<!-- try: -->
    module com.foo.bar
     maven:"my-group:my-artifact" 
     "1.2"{
     import maven:"my-group:other-module" "1.2";
    } 

To make another Java module depend on your Ceylon module, simply declare the
dependency in your `pom.xml` as you would normally:

<!-- try: -->
<!-- lang:xml -->
    <dependency>
      <groupId>my-group</groupId>
      <artifactId>my-artifact</artifactId>
      <version>1.2</version>
    </dependency>

## Tests

Declare your test module in `src/test/ceylon` and run `mvn test`, which will invoke the `ceylon test`
tool on your test module. You can generate reports as usual with:

<!-- try: -->
<!-- lang:xml -->
    <reporting>
      <plugins>
        <plugin>
          <groupId>org.apache.maven.plugins</groupId>
          <artifactId>maven-surefire-report-plugin</artifactId>
          <version>2.19.1</version>
        </plugin>
      </plugins>
    </reporting>

Note that your test module's coordinates or dependencies do not need to match the dependencies declared
in the `pom.xml`, so you don't need to declare any `test` dependencies in the `pom.xml`.

## JVM or JavaScript backend

The Maven Ceylon plugin supports both JVM and JS modules, either single-backend or multi-backend.

## Overriding phases

The Maven Ceylon plugin will hook into the proper phases by default, but you can override them by
specifying the set of phases:

<!-- try: -->
<!-- lang:xml -->
    <execution>
      <goals>
        <goal>compile</goal>
        <goal>compile-js</goal>
        <goal>testCompile</goal>
        <goal>testCompile-js</goal>
        <goal>test</goal>
        <goal>test-js</goal>
      </goals>
    </execution>

See the [Maven Ceylon plugin documentation](for more information).

## Depending on Ceylon Herd modules

Sometimes Ceylon Herd will have modules not published in Maven Central, but you can use Herd
as a Maven repository by adding this to your `pom.xml`:

<!-- try: -->
<!-- lang:xml -->
    <repositories>
      <repository>
        <id>herd</id>
        <name>Herd Maven repo</name>
        <url>https://modules.ceylon-lang.org/maven/1/</url>
      </repository>
    </repositories>
