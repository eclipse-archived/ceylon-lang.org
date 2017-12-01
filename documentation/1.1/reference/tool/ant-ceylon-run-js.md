---
layout: reference11
title_md: '`<ceylon-run-js>` Ant task'
tab: documentation
unique_id: docspage
author: Enrique Zamudio
doc_root: ../../..
---

# #{page.title_md}

## Usage 

**Note**: You must [declare the tasks with a `<typedef>`](../ant).

This task runs a top-level JavaScript method compiled from Ceylon code.
It requires [node.js](http://nodejs.org/) to run the generated JS code.

To execute the `com.example.foo::start` top level method in 
version 1.1 of module `com.example.foo` residing
in the `build` directory (repository):

<!-- lang: xml -->
    <target name="execute" depends="ceylon-ant-taskdefs">
      <ceylon-run-js run="start"
        module="com.example.foo/1.1">
        <rep url="build"/>
      </ceylon-run-js>
    </target>

## Description

The `<ceylon-run-js>` ant task supports execution of Ceylon modules, top-level classes 
and top-level functions compiled to JavaScript,
from a Ceylon repository using the [Ant build tool](http://ant.apache.org). 
It provides similar features to the [`ceylon run-js`](../ceylon/subcommands/ceylon-run-js.html) 
command line tool.

### Parameters

<table class="ant-parameters">
<tbody>
<tr>
<th>Attribute</th>
<th>Description</th>
<th>Required</th>
</tr>

<tr>
<td id="param-module"><code>module</code></td>
<td>The module (and, optionally, the version) to execute. Ex: `com.foo`, `com.foo/1.2`.</td>
<td>Yes</td>
</tr>

<tr>
<td><code>run</code></td>
<td>The top level class of function to run. If unspecified, a value of
"run" is used.</td>
<td>No</td>
</tr>

<tr>
<td><code>nodePath</code></td>
<td>The filesystem location of the <code>node</code> command line tool. 
If not specified it is searched in the standard executable path.</td>
<td>No</td>
</tr>

</tbody>
</table>

### Nested elements

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

<tr>
<td><code>version</code></td>
<td>The module version. If no version identifier is specified for a module, 
the module is assumed to exist in a <a href="#param-src">source directory</a>.</td>
<td>No</td>
</tr>

</tbody>
</table>

#### `<rep>`
A module repository containing the [module](#param-module) and/or dependencies. Can be specified multiple times.
Defaults to `modules`.

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

## See also

* How to [declare the tasks with a `<typedef>`](../ant).

