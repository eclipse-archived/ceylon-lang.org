---
layout: reference
title: '`<ceyloncjs>` Ant task'
tab: documentation
unique_id: docspage
author: Enrique Zamudio
doc_root: ../../..
---

# #{page.title}

## Usage 

**Note**: You must [declare the tasks with a `<taskdef>`](../ant).

This task compiles Ceylon code to JavaScript, without launching any
external tools. Because of this, you need to add several Ceylon
libraries to the classpath:

<!-- lang: xml -->
    <path id="ant-tasks">
        <pathelement location="${ceylon.home}/repo/com/redhat/ceylon/common/0.4/com.redhat.ceylon.common-0.4.jar" />
        <pathelement location="${ceylon.home}/repo/com/redhat/ceylon/ant/0.4/com.redhat.ceylon.ant-0.4.jar" />
        <pathelement location="${ceylon.home}/repo/com/redhat/ceylon/typechecker/0.4/com.redhat.ceylon.typechecker-0.4.jar" />
        <pathelement location="${ceylon.home}/repo/com/redhat/ceylon/module-resolver/0.4/com.redhat.ceylon.module-resolver-0.4.jar" />
        <pathelement location="${ceylon.home}/repo/com/redhat/ceylon/compiler/js/0.4/com.redhat.ceylon.compiler.js-0.4.jar" />
        <pathelement location="${ceylon.home}/lib/lib/antlr-3.4-complete.jar" />
        <pathelement location="${ceylon.home}/lib/json-smart-1.1.1.jar" />
    </path>
    <taskdef name="ceyloncjs" classname="com.redhat.ceylon.ant.Ceyloncjs" classpathref="ant-tasks" />

The `ceyloncjs` task is fairly similar to `ceylonc`; the difference
lies mainly with some options that are specific to JavaScript code
generation.

To compile the module `com.example.foo` whose source code is in the 
`src` directory to a module repository in the `build` directory, with 
verbose compiler messages:

<!-- lang: xml -->
    <target name="compile" depends="ceylon-ant-taskdefs">
      <ceyloncjs src="src" out="build" verbose="true">
        <module name="com.example.foo"/>
      </ceyloncjs>
    </target>

## Description

The `<ceyloncjs>` ant task supports compilation of Ceylon source code
to `.js` files in a Ceylon repository using the [Ant build tool](http://ant.apache.org). 
It provides similar features to the [`ceylon compile-js`](../ceylonc) command line tool.

### Parameters

**Note**: In addition to the parameters in the table below table, 
a nested [`<module>`](#module)s and/or a [`<files>`](#files) element is 
required.

<table class="ant-parameters">
<tbody>
<tr>
<th>Attribute</th>
<th>Description</th>
<th>Required</th>
</tr>

<tr>
<td><code>out</code></td>
<td>The output module repository (which must be publishable).</td>
<td>No, default is <i>modules</i></td>
</tr>

<tr>
<td><code>user</code></td>
<td>The user name to use when connecting to the output repository. Only used for HTTP output repositories.</td>
<td>No</td>
</tr>

<tr>
<td><code>pass</code></td>
<td>The password to use when connecting to the output repository. Only used for HTTP output repositories.</td>
<td>No</td>
</tr>

<tr>
<td><code>src</code></td>
<td>A source directory.</td>
<td>No, default is <i>source</i></td>
</tr>

<tr>
<td><code>verbose</code></td>
<td>Whether the compiler should emit verbose logging information.</td>
<td>No, default is <i>false</i></td>
</tr>

<tr>
<td><code>wrapModule</code></td>
<td>Whether the generated JavaScript should be wrapped in CommonJS module format.</td>
<td>No, default is <i>true</i></td>
</tr>

<tr>
<td><code>optimize</code></td>
<td>Whether the JavaScript code should be generated using prototype style.</td>
<td>No, default is <i>false</i></td>
</tr>

<tr>
<td><code>srcArchive</code></td>
<td>Whether the compiler should generate the .src archive or not.
This is useful when doing joint compilation to bytecode and JS, to avoid
generating the .src archive twice.</td>
<td>No, default is <i>true</i></td>
</tr>

</tbody>
</table>

### Nested parameters

**Note**: Unlike ant's `<javac>` task, `<ceyloncjs>` does not support an implict
[FileSet](http://ant.apache.org/manual/Types/fileset.html) so you cannot
add `<include>`/`<exclude>` etc as direct subelements. You must use 
[`<files>`](#files) explicitly.

#### `<module>`
A module to compile. Can be specified multiple times.

<table class="ant-parameters">
<tbody>
<tr>
<th>Attribute</th>
<th>Description</th>
<th>Required</th>
</tr>

<tr>
<td><code>name</code></td>
<td>The module name</td>
<td>Yes</td>
</tr>

</tbody>
</table>

#### `<files>`
A [FileSet](http://ant.apache.org/manual/Types/fileset.html) of source files 
to pass to ceyloncjs.

#### `<rep>`
A module repository containing dependencies. Can be specified multiple times. Defaults to `modules`.

<table class="ant-parameters">
<tbody>
<tr>
<th>Attribute</th>
<th>Description</th>
<th>Required</th>
</tr>

<tr>
<td><code>url</code></td>
<td>The URL of the module repository</td>
<td>Yes</td>
</tr>

</tbody>
</table>

### Output

The `<ceyloncjs>` task outputs a JS file and a source archive for 
each module named on the command line.

## See also

* How to [declare the tasks with a `<taskdef>`](../ant).

