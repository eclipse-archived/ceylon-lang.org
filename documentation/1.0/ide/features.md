---
title: Ceylon IDE Features
layout: default
tab: features
unique_id: idefeaturespage
author: Gavin King
---
<h1 style="text-align:center">Features of Ceylon IDE</h1>
<div style="margin-left:15%;margin-right:15%;text-shadow: 0 -1px 1px #ffffff;padding-bottom:10px;">
<p style="margin-left:15%;margin-right:15%;text-align:center">
Ceylon IDE is a full-featured development environment based on the Eclipse platform. It's of
central importance to the Ceylon project, and we're continuously improving it.<br/> 
With the Ceylon language and IDE, you'll be much more productive. Here's a quick list of just
some of what you get.</p>


<div class="feature">
<h2>Intelligent proposals</h2>
<p>The compiler and IDE work together to find bugs in your code and propose solutions:
the editor features quick fixes for errors, and oodles of contextual quick assists.</p>
<div>
<img src="/images/screenshots/m6/quickfix.png" style="box-shadow: 0 0 15px #888;"/>
<img src="/images/screenshots/m6/quickassist.png" style="box-shadow: 0 0 15px #888;"/>
</div>
</div>

<div style="text-align:right" class="feature">
<h2>Refactoring</h2>
<p>The IDE features Rename, Extract Function, Extract Value, Inline, and Move To New Unit
refactorings. Even better, it fully integrates with the Eclipse's tooling for moving and 
copying files, for renaming and copying packages, and for renaming Java program elements.</p>
<p>You can rename a declaration using the editor's inline "linked mode".</p>
<div>
<img src="/images/screenshots/m6/rename.png" style="box-shadow: 0 0 15px #888;"/>
</div>
<p>The refactoring wizards provide previews of changes before applying them.</p>
<div>
<img src="/images/screenshots/m6/refactor1.png" style="box-shadow: 0 0 15px #888;"/>
<!--img src="/images/screenshots/m6/refactor2.png" style="box-shadow: 0 0 15px #888;"/-->
</div>
</div>

<div class="feature">
<h2>Autocompletion</h2>
<p>We haven't forgotten everyone's favorite feature of an IDE: contextual autocompletion.
Autocompletion will even find modules for you, in Herd, or elsewhere!</p>
<div>
<img src="/images/screenshots/m6/autocomplete2.png" style="box-shadow: 0 0 15px #888;"/>
</div>
<p>Autocompletion even supports "linked mode" argument proposals.</p>
<div>
<img src="/images/screenshots/m6/autocomplete1.png" style="box-shadow: 0 0 15px #888;"/>
<img src="/images/screenshots/m6/autocomplete3.png" style="box-shadow: 0 0 15px #888;"/>
</div>
</div>

<div style="text-align:right" class="feature">
<h2>Finding and searching</h2>
<p>With Find References, Find Assignments, Find Subtypes, and the Ceylon Search page,
you shouldn't be short of ways to find stuff.</p>
<div>
<img src="/images/screenshots/m6/findmenu.png" style="box-shadow: 0 0 15px #888;"/>
</div>
<div>
<img src="/images/screenshots/m6/find.png" style="box-shadow: 0 0 15px #888;"/>
</div>
</div>

<div class="feature">
<h2>Navigation and hover</h2>
<p>To understand and maintain a large codebase, there's nothing more important than
easy navigation between code, and easy access to its API documentation. Ceylon IDE
provides hyperlink-style "go to" navigation to any referenced declaration, package,
or module, including Java declarations.</p>

<p>The Open Ceylon Declaration dialog is the quickest way to get to a toplevel 
declaration from wherever you are.</p>
<div style="text-align:center">
<img src="/images/screenshots/m6/open.png" style="box-shadow: 0 0 15px #888;"/>
</div>
<p>Hover puts the documentation for any program element right at your pointer.
Hover over a declaration and see its API documentation, dynamically compiled.
Hover over a <code>value</code> or <code>function</code> keyword, and see the inferred type.</p>
<div>
<img src="/images/screenshots/m6/hover.png" style="box-shadow: 0 0 15px #888;"/>
</div>
<p>The popup outline and type hierarchy controls provide two extra useful ways to 
navigate your code.</p>
<div>
<img src="/images/screenshots/m6/popuphierarchy.png" style="box-shadow: 0 0 15px #888;vertical-align:top"/>
<img src="/images/screenshots/m6/popupoutline.png" style="box-shadow: 0 0 15px #888;"/>
</div>
</div>

<div style="text-align:right" class="feature">
<h2>Syntax highlighting, outlining, and structural compare</h2>
<p>The editor features configurable syntax highlighting, occurrence marking, search
result highlighting, a helpful outline view, and code folding. The editor integrates 
with Eclipse's merge viewer for team-based development.</p>
<div>
<img src="/images/screenshots/m6/outline.png" style="box-shadow: 0 0 15px #888;"/>
<img src="/images/screenshots/m6/compare.png" style="box-shadow: 0 0 15px #888;"/>
</div>
<p>Of course, we're skipping over so much that the editor has to offer: paste-with-imports,
autoindentation, autoclosing, Clean Imports, Reveal Inferred Types, the awesome Terminate 
Statement command, configurable keyboard accelerators, and much more!
</div>

<div class="feature">
<h2>Incremental compilation and interactive error reporting</h2>
<p>Ceylon IDE typechecks your code as you type, immediately highlighting any
errors, and incrementally compiles your changes when you save a file. A Ceylon 
project may be configured to build for the JVM, for JavaScript, or both. The IDE 
even supports cross-project builds and inter-compilation with native Java code.</p>

<p> The compiler may be configured within the IDE via the project properties page, 
or New Ceylon Project wizard.</p>
<div>
<img src="/images/screenshots/m6/project0.png" style="box-shadow: 0 0 15px #888;"/>
</div>
<p>The Module Repositories page lets us specify the module repositories where
Ceylon will look for dependencies. The settings are persisted in a configuration
file also understood by the command line toolset.</p>
<div>
<img src="/images/screenshots/m6/project1.png" style="box-shadow: 0 0 15px #888;"/>
</div>
</div>

<div style="text-align:right" class="feature">
<h2>Wizards</h2>
<p>The IDE provides wizards for creating new Ceylon projects, modules, packages, and
source files. There's even a wizard for exporting a project module to a module 
repository.</p>
<div>
<img src="/images/screenshots/m6/newmodule.png" style="box-shadow: 0 0 15px #888;"/>
</div>
<div style="text-align:left">
<img src="/images/screenshots/m6/newproject.png" style="box-shadow: 0 0 15px #888;"/>
</div>
</div>

<div class="feature">
<h2>Project and repository explorers</h2>
<p>The Ceylon perspective offers the Ceylon Project Explorer and Ceylon Repository Explorer.
The Repository Explorer lets you quickly view all the modules available in Ceylon Herd, or 
in whatever other module repositories you select, together with their documentation and
version information.</p>
<div>
<img src="/images/screenshots/m6/repoexplorer.png" style="box-shadow: 0 0 15px #888;"/>
</div>
</div>

<div style="text-align:right" class="feature">
<h2>Run, test, and debug</h2>
<p>You can run and debug your Ceylon projects on Ceylon's modular runtime for the JVM, or 
on Node.js, directly from the IDE.</p>
<div>
<img src="/images/screenshots/m6/run.png" style="box-shadow: 0 0 15px #888;"/>
</div>
<p>You can even run tests written with the Ceylon SDK's testing module.</p>
<div>
<img src="/images/screenshots/m6/test.png" style="box-shadow: 0 0 15px #888;"/>
</div>
</div>

<div class="feature">
<h2>Customization</h2>
<p>Of course, with so much functionality on offer, we had to provide some switches and
toggles to let you get it working just the way you prefer.</p>
<div>
<img src="/images/screenshots/m6/preferences.png" style="box-shadow: 0 0 15px #888;"/>
</div>
</div>


<p style="margin-left:15%;margin-right:15%;text-align:center">
Get Ceylon IDE from the <a href="../install">update site</a>.</p>

</div>