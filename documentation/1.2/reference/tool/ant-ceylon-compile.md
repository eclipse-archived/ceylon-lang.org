---
layout: reference12
title_md: '`<ceylon-compile>` Ant task'
tab: documentation
unique_id: docspage
author: Tom Bentley
doc_root: ../../..
---

# #{page.title_md}

## Usage 

**Note**: You must [declare the tasks with a `<typedef>`](../ant).

To compile the module `com.example.foo` whose source code is in the 
`src` directory to a module repository in the `build` directory, with 
verbose compiler messages:

<!-- lang: xml -->
    <target name="compile" depends="ceylon-ant-taskdefs">
      <ceylon-compile src="src" out="build" verbose="true">
        <module name="com.example.foo"/>
      </ceylon-compile>
    </target>

## Description

The `<ceylon-compile>` ant task supports compilation of Ceylon and Java source code
to `.car` archives in a Ceylon repository using the [Ant build tool](http://ant.apache.org). 
It provides similar features to the [`ceylon compile`](../ceylon/subcommands/ceylon-compile.html) 
command line tool.

### Parameters

**Note**: In addition to the parameters in the table below, 
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
<td><code>encoding</code></td>
<td>The character encoding used for source files</td>
<td>No, default is the OS default encoding</td>
</tr>

<tr>
<td><code>verbose</code></td>
<td>Whether the compiler should emit verbose logging information. The zero or more of the
following flags can be passed separated by commas: 'all', 'loader', 'ast', 'code', 'cmr' or
'benchmark'. If you do not pass a flag 'all' will be assumed.</td>
<td>No</td>
</tr>

<tr>
<td><code>nomtimecheck</code></td>
<td>Whether to perform a comparison of file modification times to determine 
whether to compile a module or file. The most recent modification time of the source files
is compared with the oldest modification time of the output artifacts. 
This can speed up builds when the source files have not 
changed but is not able to detect deletion of source files.</td>
<td>No, default is <i>false</i></td>
</tr>

<tr>
<td><code>executable</code></td>
<td>The filesystem location of the <code>ceylon</code> command line tool. 
If not specified it is searched in the directory indicated by 
the <code>ceylon.home</code> system property, or if that is not set 
the <code>CEYLON_HOME</code> environment variable.</td>
<td>No</td>
</tr>

</tbody>
</table>

### Nested elements

**Note**: Unlike ant's `<javac>` task, `<ceylon-compile>` does not support an implict
[FileSet](http://ant.apache.org/manual/Types/fileset.html) so you cannot
add `<include>`/`<exclude>` etc as direct subelements. You must use 
[`<files>`](#files) explicitly.

#### `<moduleset>`

A reference to a [`<moduleset>`](../ant#reposet) defined elsewhere in the 
ant build file. 

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
to pass to `ceylon compile`.

#### `<reposet>`
A reference to a [`<reposet>`](../ant#reposet) defined elsewhere in the 
ant build file. 

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

#### `<javacoption>`
The text between begin and end tags will be passed as an option to the underlying
Java compiler. Optionally it is possible to use the attributes listed below which
will then be interpreted as passing `-key:value` to the compiler.

<table class="ant-parameters">
<tbody>
<tr>
<th>Attribute</th>
<th>Description</th>
<th>Required</th>
</tr>

<tr>
<td><code>key</code></td>
<td>The name of the option to pass</td>
<td>No</td>
</tr>

<tr>
<td><code>value</code></td>
<td>The value of the option to pass</td>
<td>No</td>
</tr>

</tbody>
</table>

### Output

The `<ceylon-compile>` task outputs a module archive and a source archive for 
each module named on the command line. The compiler produces `.car` files 
directly; it does not produce individual `.class` files as `javac` does.

## See also

* How to [declare the tasks with a `<typedef>`](../ant).

