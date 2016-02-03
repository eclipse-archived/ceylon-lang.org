---
layout: reference12
title_md: '`<ceylon-war>` Ant task'
tab: documentation
unique_id: docspage
author: Tom Bentley
doc_root: ../../..
---

# #{page.title_md}

## Usage 

**Note**: You must [declare the tasks with a `<typedef>`](../ant).

## Description

The `<ceylon-war>` ant task generates a `.war` file from a compiled `.car` file 
using the [Ant build tool](http://ant.apache.org). 
It provides similar features to the [`ceylon war`](../ceylon/subcommands/ceylon-war.html) 
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
<td><code>name</code></td>
<td>Equivalent to the `--name` command line option:
Sets name of the WAR file (default: <i>moduleName</i>-<i>version</i>.war).</td>
<td>No</td>
</tr>

<tr>
<td><code>out</code></td>
<td>Equivalent to the `--out` command line option:
Sets the output directory for the WAR file (default: .).</td>
<td>No</td>
</tr>

<tr>
<td><code>resourceRoot</code></td>
<td>Equivalent to the `--resource-root` command line option:
Sets the special resource directory whose files will 
end up in the root of the resulting `.war` file (default: web-content).</td>
<td>No</td>
</tr>



<tr>
<td><code>linkWithCurrentDistribution</code></td>
<td>Equivalent to the `--link-with-current-distribution` command line option:
Link modules which were compiled with a more recent 
version of the distribution to the version of that module 
present in this distribution.</td>
<td>No</td>
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

#### `<exclude>`
A module to exclude from the WAR file. The `module` attribute
of the nested `<exclude>` element can be a module name or a
file containing module names.

<table class="ant-parameters">
<tbody>
<tr>
<th>Attribute</th>
<th>Description</th>
<th>Required</th>
</tr>

<tr>
<td><code>module</code></td>
<td>The name of the module to be excluded, or a file containing modules 
names to be excluded</td>
<td>No</td>
</tr>

</tbody>
</table>

## See also

* How to [declare the tasks with a `<typedef>`](../ant).

