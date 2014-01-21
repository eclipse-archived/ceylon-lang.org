---
layout: reference
title_md: '`<ceylon-doc>` Ant task'
tab: documentation
unique_id: docspage
author: Tom Bentley
doc_root: ../../..
---

# #{page.title_md}

## Usage 

**Note**: In M5 the `<ceylond>` task was renamed `<ceylon-doc>`.

**Note**: You must [declare the tasks with a `<typedef>`](../ant).

To compile the documentation for module `com.example.foo` whose 
source code is in the `src` directory to a module repository in 
the `build` directory:

<!-- lang: xml -->
    <target name="documentation" depends="ceylon-ant-taskdefs">
      <ceylon-doc src="src" out="build">
        <module name="com.example.foo"/>
      </ceylon-doc>
    </target>
    
To compile the documentation for version 1.1 of module `com.example.foo` 
whose source code is in the `build` directory to a module repository in 
the `build` directory:

<!-- lang: xml -->
    <target name="documentation" depends="ceylon-ant-taskdefs">
      <ceylon-doc out="build">
        <module name="com.example.foo" version="1.1"/>
      </ceylon-doc>
    </target>

## Description

The `<ceylon-doc>` ant task supports documentation of Ceylon and Java source code
to a Ceylon repository using the [Ant build tool](http://ant.apache.org). 
It provides similar features to the [`ceylon doc`](../ceylon/subcommands/ceylon-doc.html) 
command line tool.

### Parameters

**Note**: In addition to the parameters in the table below table, 
a nested [`<module>`](#module)(s) is required.

<table class="ant-parameters">
<tbody>
<tr>
<th>Attribute</th>
<th>Description</th>
<th>Required</th>
</tr>

<tr>
<td id="param-src"><code>src</code></td>
<td>A source directory.</td>
<td>No, default is <i>source</i></td>
</tr>

<tr>
<td><code>encoding</code></td>
<td>The character encoding used for source files</td>
<td>No, default is the OS default encoding</td>
</tr>

<tr>
<td><code>out</code></td>
<td>The output module repository (which must be publishable).</td>
<td>No, default is <i>modules</i></td>
</tr>

<tr>
<td><code>includeNonShared</code></td>
<td>Whether to document non-<code>shared</code> declarations.</td>
<td>No, default is <i>false</i></td>
</tr>

<tr>
<td><code>includeSourceCode</code></td>
<td>Whether to include the source code in the documentation.</td>
<td>No, default is <i>false</i></td>
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
<td><code>nomtimecheck</code></td>
<td>Whether to perform a comparison of file modification times to determine 
whether to document a module. The most recent modification time of the source files
is compared with the oldest modification time of the output artifacts. 
This can speed up builds when the source files have not 
changed but is not able to detect deletion of source files. <!-- m3 --></td>
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

<tr>
<td><code>verbose</code></td>
<td>Whether the documentation generator should emit verbose logging information. The zero or more of the
following flags can be passed separated by commas: 'all' or 'loader'.
If you do not pass a flag 'all' will be assumed.</td>
<td>No</td>
</tr>

</tbody>
</table>

### Nested elements

**Note**: Unlike ant's `<javadoc>` task, `<ceylond>` does not support an implict
[FileSet](http://ant.apache.org/manual/Types/fileset.html) so you cannot
add `<include>`/`<exclude>` etc as direct subelements. You must use 
[`<files>`](#files) explicitly.


#### `<moduleset>`
A reference to a [`<moduleset>`](../ant#reposet) defined elsewhere in the 
ant build file. 

#### `<module>`
A module to document. Can be specified multiple times.

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

<tr>
<td><code>version</code></td>
<td>The module version. If no version identifier is specified for a module, 
the module is assumed to exist in a <a href="#param-src">source directory</a>.</td>
<td>No</td>
</tr>

</tbody>
</table>

#### `<reposet>`
A reference to a [`<reposet>`](../ant#reposet) defined elsewhere in the 
ant build file. 

#### `<rep>`
A module repository containing dependencies. Can be specified multiple times. Default to `modules`.

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

The `<ceylon-doc>` task outputs a module documentation folder for 
each module named on the command line. The documentation generator produceds `module-doc` 
folders directly, in the output module repository.

## See also

* How to [declare the tasks with a `<typedef>`](../ant).

