---
title: Ceylon IDE for IntelliJ Features
layout: default
tab: features
unique_id: idefeaturespage
author: Gavin King
---
<p/>
<h1 style="text-align:center">Features of Ceylon IDE for IntelliJ</h1>
<div style="margin-left:15%;margin-right:15%;text-shadow: 0 -1px 1px #ffffff;padding-bottom:10px;">
<p style="margin-left:15%;margin-right:15%;text-align:center"><b>
Ceylon IDE for IntelliJ is a full-featured development environment based on IntelliJ IDEA
and compatible with Android Studio. 
It's of central importance to the Ceylon project, and we're continuously improving it.<br/> 
With the Ceylon language and IDE, you'll be much more productive. Here's a quick list of just
some of what you get.</b></p>


<div class="feature">
<h2>Intelligent proposals</h2>
<p>The compiler and IDE work together to find bugs in your code as you're typing and propose 
solutions.</p>
<div>
<img src="/images/screenshots/1.3.0/intellij/error.png" width="80%" style="box-shadow: 0 0 15px #888;"/>
<img src="/images/screenshots/1.3.0/intellij/error-fixes.png" width="90%" style="box-shadow: 0 0 15px #888;"/>
</div>
<p>The editor features quick fixes for errors, and oodles of other contextual intention actions.</p>
<div>
<img src="/images/screenshots/1.3.0/intellij/quick-fix.png" width="50%" style="box-shadow: 0 0 15px #888;"/>
<img src="/images/screenshots/1.3.0/intellij/quick-assist.png" width="45%" style="box-shadow: 0 0 15px #888;"/>
</div>
<p>Some proposals even feature an interactive linked mode.</p> 
<div>
<img src="/images/screenshots/1.3.0/intellij/linked-mode.png" width="40%" style="box-shadow: 0 0 15px #888;"/>
<img src="/images/screenshots/1.3.0/intellij/select-resolution.png" width="55%" style="box-shadow: 0 0 15px #888;vertical-align:top"/>
</div>
<p>All this assistance makes it easier to learn the language, understand error messages, and 
improve your code.</p>
</div>

<div class="feature" style="text-align:right">
<h2>Contextual completion</h2>
<p>We haven't forgotten everyone's favorite feature of an IDE: contextual autocompletion.
Completion in Ceylon IDE supports "linked mode" argument proposals, a feature available
in other IDEs that's still missing from IntelliJ's Java editor.</p>
<div>
<img src="/images/screenshots/1.3.0/intellij/complete-type.png" width="60%" style="box-shadow: 0 0 15px #888;"/>
<img src="/images/screenshots/1.3.0/intellij/complete-arg.png" width="35%" style="box-shadow: 0 0 15px #888;"/>
</div>
<p>Naturally, chain completion is also available.</p>
<div>
<img src="/images/screenshots/1.3.0/intellij/chain-completion.png" width="70%" style="box-shadow: 0 0 15px #888;"/>
</div>
<p>Completion will even find and propose modules for you, searching the Herd, the Java SDK, 
and any other module repository you're using in your project!</p>
<div>
<img src="/images/screenshots/1.3.0/intellij/complete-module-name.png" width="45%" style="box-shadow: 0 0 15px #888;"/>
<img src="/images/screenshots/1.3.0/intellij/complete-module-version.png" width="45%" style="box-shadow: 0 0 15px #888;"/>
<img src="/images/screenshots/1.3.0/intellij/complete-module.png" width="60%" style="box-shadow: 0 0 15px #888;"/>
</div>
<p>
</div>

<div class="feature">
<h2>Refactoring</h2>
<p>The IDE features **Rename**, **Inline**, **Extract Function**, **Extract Value**, 
and **Change Signature** refactorings. Rename supports inline "linked mode".</p>
<div>
<img src="/images/screenshots/1.3.0/intellij/rename.png" width="60%" style="box-shadow: 0 0 15px #888;"/>
</div>
<p>n **Extract** refactoring lets you select a containing expression, a target scope,
in the case of extracting a function, and then allows customization of the extracted 
function or value name in linked mode.</p>
<div>
<img src="/images/screenshots/1.3.0/intellij/select-expression.png" width="45%" style="box-shadow: 0 0 15px #888;"/><br/>
<img src="/images/screenshots/1.3.0/intellij/target-scope.png" width="60%" style="box-shadow: 0 0 15px #888;vertical-align:top;"/>
<img src="/images/screenshots/1.3.0/intellij/extract-value.png" width="35%" style="box-shadow: 0 0 15px #888;"/>
</div>
<p>**Change Signature** lets you change the signature of a function, renaming, 
reordering, adding, and removing parameters, or adding and inlining default 
arguments.</p>
<div style="text-align:center">
<img src="/images/screenshots/1.3.0/intellij/change-signature.png" width="60%" style="box-shadow: 0 0 15px #888;"/>
</div>
</div>

<div style="text-align:right" class="feature">
<h2>Navigation</h2>
<p>To understand and maintain a large codebase, there's nothing more important than
easy navigation between code. Ceylon IDE provides hyperlink-style "go to" navigation 
to any referenced declaration, package, or module, including Java declarations.</p>
<div>
<img src="/images/screenshots/1.3.0/intellij/goto.png" width="90%" style="box-shadow: 0 0 15px #888;"/>
</div>
<p>**Navigate > Implementations**, **Navigate > Supertype Declaration**, and
**Navigate > Type Declaration** let us easily get from one place to another within
an inheritance hierarchy. Gutter icons indicate member refinement.</p>
<div>
<img src="/images/screenshots/1.3.0/intellij/implementations.png" width="75%" style="box-shadow: 0 0 15px #888;"/>
<img src="/images/screenshots/1.3.0/intellij/supertypes.png" width="75%" style="box-shadow: 0 0 15px #888;"/>
</div>
<p>On the other hand, the **Navigate > Class** and **Navigate > Symbol** popup dialogs 
are the quickest ways to get to a named declaration from wherever you are.</p>
<div>
<img src="/images/screenshots/1.3.0/intellij/navigate-class.png" width="65%" style="box-shadow: 0 0 15px #888;"/>
</div>
<p>The **Structure** tool window and **File Structure** popup make it easy to navigate 
within the current file.</p>
<div>
<img src="/images/screenshots/1.3.0/intellij/structure.png" width="40%" style="box-shadow: 0 0 15px #888;"/>
</div>
</div>

<div class="feature">
<h2>Inheritance hierarchy</h2>
<p>The **Type Hierarchy** and **Method Hierarchy** let you easily explore inheritance
relationships. They even show relationships between Ceylon and Java types.</p>
<div style="text-align:center">
<img src="/images/screenshots/1.3.0/intellij/type-hierarchy.png" width="55%" style="box-shadow: 0 0 15px #888"/>
</div>
<p>**Implement Formal Members** and **Refine Inherited Members** are a quick way to
select and fill in the signature of several supertype members at once.</p>
<div style="text-align:center">
<img src="/images/screenshots/1.3.0/intellij/implement-members.png" width="55%" style="box-shadow: 0 0 15px #888"/>
</div>
</div>

<div style="text-align:right" class="feature">
<h2>Searching</h2>
<p>With **Find Usages** you can view references to a Ceylon declaration in the
**Find** tool window. References are categorized by usage type and location.</p>
<div>
<img src="/images/screenshots/1.3.0/intellij/find-usages.png" width="80%" style="box-shadow: 0 0 15px #888;"/>
</div>
<p>If you're in a hurry, you can view references in a popup!</p>
<div>
<img src="/images/screenshots/1.3.0/intellij/popup-usages.png" width="70%" style="box-shadow: 0 0 15px #888;"/>
</div>
</div>

<div class="feature">
<h2>Online documentation</h2>
<p>**Quick Documentation** puts the API documentation, dynamically compiled, for any 
program element right at your pointer. (**Quick Definition** displays the code.)</p>
<div style="text-align:center">
<img src="/images/screenshots/1.3.0/intellij/documentation.png" width="60%" style="box-shadow: 0 0 15px #888;"/>
</div>
<p>When you're in a hurry, **Parameter Info** and **Expression Type** tell you 
immediately what you need to know about the parameters of a function or the
type of an expresssion or inferred value.</p>
<div>
<img src="/images/screenshots/1.3.0/intellij/parameter-info.png" width="45%" style="box-shadow: 0 0 15px #888;"/>
<img src="/images/screenshots/1.3.0/intellij/expression-type.png" width="45%" style="box-shadow: 0 0 15px #888;"/>
</div>
</div>

<div style="text-align:right" class="feature">
<h2>Incremental error reporting</h2>
<p>Unlike IntelliJ's Java editor, Ceylon IDE analyzes impacts of your code edits on other
project source files as you're working, and reports problems in the whole project in
the **Ceylon Problems** tool window, without requiring you to explicitly call Make.</p>
<div style="text-align:center">
<img src="/images/screenshots/1.3.0/intellij/problems.png" width="70%" style="box-shadow: 0 0 15px #888;"/>
</div>
</div>

<div class="feature">
<h2>Wizards and customization</h2>
<p>Naturally, Ceylon IDE offers tools for creating modules and source files, creating 
and configuring projects and their dependencies, and for customizing the behavior of
the IDE.</p>
<div>
<img src="/images/screenshots/1.3.0/intellij/new-file.png" width="32%" style="box-shadow: 0 0 15px #888;"/>
<img src="/images/screenshots/1.3.0/intellij/completion-preferences.png" width="32%" style="box-shadow: 0 0 15px #888;"/>
<img src="/images/screenshots/1.3.0/intellij/module-repositories.png" width="32%" style="box-shadow: 0 0 15px #888;"/>
</div>
</div>

<p>Of course, there's much more to Ceylon IDE: customizable syntax highlighting,
code folding, breadcrumbs, formatting and auto-indentation, **Optimize Imports**, 
insert imports on paste, **Paste Java as Ceylon**, **Surround With**, **Unwrap**, 
**Move Statement**, **Move Element**, not to mention running and debugging.</p>

<p style="margin-left:15%;margin-right:15%;text-align:center">
Get Ceylon IDE for IntelliJ from the <a href="../install">download site</a>.</p>

</div>