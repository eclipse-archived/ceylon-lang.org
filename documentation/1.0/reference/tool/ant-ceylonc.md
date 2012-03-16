---
layout: reference
title: `<ceylonc>` Ant task
tab: documentation
unique_id: docspage
author: Tom Bentley
doc_root: ../../..
---

# #{page.title}

## Usage 

**Note**: You must [declare the tasks with a `<taskdef>`](../ant).

To compile the module `com.example.foo` whose source code is in the 
`src` directory to a module repository in the `build` directory, with 
verbose compiler messages:

<!-- lang: xml -->
    <target name="compile" depends="ceylon-ant-taskdefs">
      <ceylonc src="src" out="build" verbose="true">
        <module name="com.example.foo"/>
      </ceylonc>
    </target>

## Description

The `<celyonc>` ant task supports compilation of Ceylon and Java source code
to `.car` archives in a Ceylon repository using the [Ant build tool](http://ant.apache.org). 
It provides similar features to the [`ceylonc`](../ceylonc) command line tool.

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
<td>The user name to use when connecting to the output repository. Only used for HTTP output repositories. <!-- m2 --></td>
<td>No</td>
</tr>

<tr>
<td><code>pass</code></td>
<td>The password to use when connecting to the output repository. Only used for HTTP output repositories. <!-- m2 --></td>
<td>No</td>
</tr>

<tr>
<td><code>src</code></td>
<td>A source directory.</td>
<td>No, default is <i>source</i></td>
</tr>

<tr>
<td><code>verbose</code></td>
<td>Whether the compiler should emit verbose logging information. <!-- m2 --></td>
<td>No, default is <i>false</i></td>
</tr>

<tr>
<td><code>classpath</code></td>
<td>The classpath to use. Only useful if you depend on local jars or Java classes.</td>
<td>No</td>
</tr>

<tr>
<td><code>classpathref</code></td>
<td>The classpath to use, given as a 
[reference](http://ant.apache.org/manual/using.html#references) 
to a path defined elsewhere. Only useful if you depend on local jars or Java classes.</td>
<td>No</td>
</tr>

<tr>
<td><code>executable</code></td>
<td>The filesystem location of the <code>ceylonc</code> command line tool. 
If not specified it is searched in the directory indicated by 
the <code>ceylon.home</code> system property, or if that is not set 
the <code>CEYLON_HOME</code> environment variable.</td>
<td>No</td>
</tr>

</tbody>
</table>

### Nested parameters

**Note**: Unlike ant's `<javac>` task, `<ceylonc>` does not support an implict
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
to pass to ceylonc. <!-- m2 -->

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

The `<ceylonc>` task outputs a module archive and a source archive for 
each module named on the command line. The compiler produceds `.car` files 
directly is does not produce individual `.class` files as `javac` does.

## See also

* How to [declare the tasks with a `<taskdef>`](../ant).

