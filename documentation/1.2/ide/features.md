---
title: Ceylon IDE Features
layout: default
tab: features
unique_id: idefeaturespage
author: Gavin King
---
<p/>
<h1 style="text-align:center">Features of Ceylon IDE</h1>
<div style="margin-left:15%;margin-right:15%;text-shadow: 0 -1px 1px #ffffff;padding-bottom:10px;">
<p style="margin-left:15%;margin-right:15%;text-align:center"><b>
Ceylon IDE is a full-featured development environment based on the Eclipse platform. It's of
central importance to the Ceylon project, and we're continuously improving it.<br/> 
With the Ceylon language and IDE, you'll be much more productive. Here's a quick list of just
some of what you get.</b></p>


<div class="feature">
<h2>Intelligent proposals</h2>
<p>The compiler and IDE work together to find bugs in your code and propose solutions:
the editor features quick fixes for errors, and oodles of contextual quick assists.</p>
<div>
<img src="/images/screenshots/1.2.0/quick-fix.png" width="55%" style="box-shadow: 0 0 15px #888;"/>
<img src="/images/screenshots/1.2.0/quick-assist.png" width="40%" style="box-shadow: 0 0 15px #888;"/>
</div>
<p>Some proposals offer an interactive linked mode.</p> 
<div>
<img src="/images/screenshots/1.2.0/assign-to-local.png" width="45%" style="box-shadow: 0 0 15px #888;"/>
</div>
</div>

<div style="text-align:right" class="feature">
<h2>Refactoring</h2>
<p>The IDE features **Rename**, **Inline**, **Extract Function**, **Extract Value**, 
**Extract Parameter**, **Change Parameter List**, **Collect Parameters**, **Move Out**, 
**Make Receiver**, **Enter Import Alias**, **Introduce Type Alias**, **Extract Interface**, 
**Invert Boolean**, **Move To Unit**, and **Move To New Unit** refactorings. Even better, 
it fully integrates with Eclipse's tooling for moving and copying files, for renaming and 
copying packages, and for renaming Java program elements.</p>
<p>You can rename a declaration using the editor's inline "linked mode".</p>
<div>
<img src="/images/screenshots/1.2.0/rename.png" width="60%" style="box-shadow: 0 0 15px #888;"/>
</div>
<p>**Extract** refactorings let you select a containing expression.</p>
<div>
<img src="/images/screenshots/1.2.0/extract-function.png" width="80%" style="box-shadow: 0 0 15px #888;"/>
</div>
<p>**Change Parameter List** lets you change the signature of a method, including adding 
or inlining default arguments.</p>
<div>
<img src="/images/screenshots/1.2.0/change-parameters.png" width="70%" style="box-shadow: 0 0 15px #888;"/>
</div>
<p>The refactoring wizards provide previews of changes before applying them.</p>
<div>
<img src="/images/screenshots/1.2.0/preview.png" width="75%" style="box-shadow: 0 0 15px #888;"/>
</div>
</div>

<div class="feature">
<h2>Autocompletion</h2>
<p>We haven't forgotten everyone's favorite feature of an IDE: contextual autocompletion.
Autocompletion will even find modules for you, in Herd, or elsewhere!</p>
<div>
<img src="/images/screenshots/1.2.0/complete-module.png" width="70%" style="box-shadow: 0 0 15px #888;"/>
<img src="/images/screenshots/1.2.0/complete-version.png" width="25%" style="box-shadow: 0 0 15px #888;"/>
</div>
<p>Autocompletion supports "linked mode" argument proposals.</p>
<div>
<img src="/images/screenshots/1.2.0/complete-type.png" width="50%" style="box-shadow: 0 0 15px #888;"/>
<img src="/images/screenshots/1.2.0/complete-arg.png" width="40%" style="box-shadow: 0 0 15px #888;"/>
</div>
<p>There's even IntelliJ-style "chain completion".</p>
<div>
<img src="/images/screenshots/1.2.0/chain-completion.png" width="80%" style="box-shadow: 0 0 15px #888;"/>
</div>
</div>

<div style="text-align:right" class="feature">
<h2>Finding and searching</h2>
<p>With **Find References**, **Find Assignments**, **Find Refinements**, 
**Find Subtypes**, and the **Ceylon Search** page, you shouldn't be short of ways 
to find stuff.</p>
<div>
<img src="/images/screenshots/1.2.0/search.png" width="60%" style="box-shadow: 0 0 15px #888;"/>
<img src="/images/screenshots/1.2.0/find-menu.png" width="35%" style="box-shadow: 0 0 15px #888;"/>
</div>
<div>
<img src="/images/screenshots/1.2.0/search-results.png" width="60%" style="box-shadow: 0 0 15px #888;"/>
</div>
<p>There's even the Quick Find References popup control.</p>
<div>
<img src="/images/screenshots/1.2.0/quick-find-references.png" width="80%" style="box-shadow: 0 0 15px #888;"/>
</div>
<p>On the other hand, the **Open Ceylon Declaration** dialog is the quickest way to 
get to a toplevel declaration from wherever you are.</p>
<div style="text-align:center">
<img src="/images/screenshots/1.2.0/open-declaration.png" width="90%" style="box-shadow: 0 0 15px #888;"/>
</div>
</div>

<div class="feature">
<h2>Navigation and hover</h2>
<p>To understand and maintain a large codebase, there's nothing more important than
easy navigation between code, and easy access to its API documentation. Ceylon IDE
provides hyperlink-style "go to" navigation to any referenced declaration, package,
or module, including Java declarations.</p>

<p>Hover puts the documentation for any program element right at your pointer.
Hover over a declaration and see its API documentation, dynamically compiled.
Hover over a <code>value</code> or <code>function</code> keyword, and see the inferred type.</p>
<div style="text-align:center">
<img src="/images/screenshots/1.2.0/hover.png" width="60%" style="box-shadow: 0 0 15px #888;"/>
</div>
<p>The popup outline and type hierarchy controls provide two extra useful ways to 
navigate your code.</p>
<div>
<img src="/images/screenshots/1.2.0/quick-hierarchy.png" width="50%" style="box-shadow: 0 0 15px #888;vertical-align:top"/>
<img src="/images/screenshots/1.2.0/quick-outline.png" width="40%" style="box-shadow: 0 0 15px #888;"/>
</div>
<p>Finally, there's the **Outline** view and an awesome **Ceylon Type Hierarchy** 
view.</p>
<div>
<img src="/images/screenshots/1.2.0/big-outline-view.png" width="40%" style="box-shadow: 0 0 15px #888;"/>
<img src="/images/screenshots/1.2.0/big-hierarchy-view.png" width="40%" style="box-shadow: 0 0 15px #888;vertical-align:top"/>
</div>
</div>

<div style="text-align:right" class="feature">
<h2>Editor, code formatter, and structural compare</h2>
<p>The editor features configurable syntax highlighting, occurrence marking, search
result highlighting, and code folding. The editor integrates with Eclipse's merge 
viewer for team-based development.</p>
<div style="text-align:center">
<img src="/images/screenshots/1.2.0/compare.png" width="80%" style="box-shadow: 0 0 15px #888;"/>
</div>
<p>The editor integrates Ceylon Formatter, a high-quality code formatter, alongside
the lightweight **Correct Indentation** and **Format Block** commands.</p>
<div style="text-align:center">
<img src="/images/screenshots/1.2.0/formatter.png" width="80%" style="box-shadow: 0 0 15px #888;"/>
</div>
<p>Of course, the editor has so much more offer: paste-with-imports, autoindentation, 
autoclosing, **Clean Imports**, **Reveal Inferred Types**, the awesome **Terminate 
Statement** command, configurable keyboard accelerators, and much more!</p>
</div>

<div class="feature">
<h2>Incremental compilation and interactive error reporting</h2>
<p>Ceylon IDE typechecks your code as you type, immediately highlighting any
errors, and incrementally compiles your changes when you save a file. A Ceylon 
project may be configured to build for the JVM, for JavaScript, or both. The IDE 
even supports cross-project builds and inter-compilation with native Java code.</p>

<p> The compiler may be configured within the IDE via the **Ceylon Build** project 
properties page, or new project wizard.</p>
<div style="text-align:center">
<img src="/images/screenshots/1.2.0/ceylon-build.png" width="70%" style="box-shadow: 0 0 15px #888;"/>
</div>
<p>The **Module Repositories** page lets us specify the module repositories where
Ceylon will look for dependencies. The settings are persisted in a configuration
file also understood by the command line toolset.</p>
<div style="text-align:center">
<img src="/images/screenshots/1.2.0/module-repositories.png" width="70%" style="box-shadow: 0 0 15px #888;"/>
</div>
<p>Finally, the **Build Paths** page lets you set up dependencies between projects.</p>
</div>

<div class="feature" style="text-align:right">
<h2>Project and repository explorers, and module dependency visualization</h2>
<p>The Ceylon perspective offers the **Ceylon Project Explorer** and 
**Ceylon Repository Explorer**. The **Repository Explorer** lets you quickly view 
all the modules available in Ceylon Herd, or in whatever other module repositories 
you select, together with their documentation and version information.</p>
<div>
<img src="/images/screenshots/1.2.0/repository-explorer.png" width="80%" style="box-shadow: 0 0 15px #888;"/>
</div>
<p>The **Module Dependencies** view really helps understand and resolve problems 
with complex inter-module dependency graphs.
<div>
<img src="/images/screenshots/1.2.0/module-dependencies.png" width="90%" style="box-shadow: 0 0 15px #888;"/>
</div>
</div>

<div class="feature">
<h2>Wizards</h2>
<p>The IDE provides wizards for creating new Ceylon modules, packages, and source 
files.</p>
<div>
<img src="/images/screenshots/1.2.0/new-module.png" width="70%" style="box-shadow: 0 0 15px #888;"/>
</div>
<p>And, naturally, a wizard for creating new projects.</p>
<div style="text-align:right">
<img src="/images/screenshots/1.2.0/new-project.png" width="70%" style="box-shadow: 0 0 15px #888;"/>
</div>
<p>There's even a wizard for exporting a project module to a module 
repository.</p>
<div>
<img src="/images/screenshots/1.2.0/export-module.png" width="70%" style="box-shadow: 0 0 15px #888;"/>
</div>
</div>

<div style="text-align:right" class="feature">
<h2>Run, test, and debug</h2>
<p>You can run and debug your Ceylon projects on Ceylon's modular runtime for the 
JVM, or on Node.js, directly from the IDE.</p>
<div>
<img src="/images/screenshots/1.2.0/run.png" width="70%" style="box-shadow: 0 0 15px #888;"/>
</div>
<p>Unlike other JVM languages, the debugger for Ceylon IDE shows the runtime type 
arguments of a generic function or instance of a generic type!</p>
<div>
<img src="/images/screenshots/1.2.0/debugger.png" width="70%" style="box-shadow: 0 0 15px #888;"/>
</div>
<p>You can even run tests written with the Ceylon SDK's testing module.</p>
<div>
<img src="/images/screenshots/1.2.0/test-view.png" width="40%" style="box-shadow: 0 0 15px #888;"/>
</div>
</div>

<div class="feature">
<h2>Customization</h2>
<p>Of course, with so much functionality on offer, we had to provide some switches and
toggles to let you get it working just the way you prefer.</p>
<div>
<img src="/images/screenshots/1.2.0/completion-preferences.png" width="32%" style="box-shadow: 0 0 15px #888;"/>
<img src="/images/screenshots/1.2.0/editor-preferences.png" width="32%" style="box-shadow: 0 0 15px #888;"/>
<img src="/images/screenshots/1.2.0/filtering.png" width="32%" style="box-shadow: 0 0 15px #888;"/>
</div>
</div>


<p style="margin-left:15%;margin-right:15%;text-align:center">
Get Ceylon IDE from the <a href="../install">update site</a>.</p>

</div>