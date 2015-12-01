---
layout: reference11
title_md: '`<ceylon-run>` Ant task'
tab: documentation
unique_id: docspage
author: Tom Bentley
doc_root: ../../..
---

# #{page.title_md}

## Usage 

**Note**: In M5 the `<ceylon>` task was renamed `<ceylon-run>`.

**Note**: You must [declare the tasks with a `<typedef>`](../ant).

To execute the `com.example.foo.lifecycle.start` top level method in 
version 1.1 of module `com.example.foo` residing
in the `build` directory (repository):

<!-- lang: xml -->
    <target name="execute" depends="ceylon-ant-taskdefs">
      <ceylon-run run="com.example.foo.lifecycle.start" 
        module="com.example.foo/1.1">
        <rep url="build"/>
      </ceylon-run>
    </target>

## Description

The `<ceylon-run>` ant task supports execution of Ceylon modules, top-level classes 
and top-level functions
from a Ceylon repository using the [Ant build tool](http://ant.apache.org). 
It provides similar features to the [`ceylon run`](../ceylon/subcommands/ceylon-run.html) 
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
<td id="param-module"><code>module</code></td>
<td>The module (and, optionally, the version) to execute. Ex: `com.foo`, `com.foo/1.2`.</td>
<td>Yes</td>
</tr>

<tr>
<td><code>run</code></td>
<td>The top level class of function to run. If unspecified the run attribute 
of the module descriptor is used.</td>
<td>No</td>
</tr>

<tr>
<td id="param-src"><code>src</code></td>
<td>A source directory.</td>
<td>No, default is <i>source</i></td>
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

#### `<reposet>`
A reference to a [`<reposet>`](../ant#reposet) defined elsewhere in the 
ant build file. 

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

