---
title: Getting started with Ceylon IDE for IntelliJ
layout: intellij13
tab: getting started
unique_id: intellijgettingstarted
author: Bastien Jansen
---

# #{page.title}

Here are the steps needed to run a simple project in IntelliJ.

Create a new project via `File > New > Project` and choose the `Ceylon` category.

<img src="/images/screenshots/intellij/getting-started/1-new-project-wizard.png" style="box-shadow: 0 0 10px #888;margin-left:10px" width="95%"/>

Click `Next` and choose whether you want to compile/run your project on the JVM, on JS or both:

<img src="/images/screenshots/intellij/getting-started/2-new-project-target.png" style="box-shadow: 0 0 10px #888;margin-left:10px" width="95%"/>

Click `Next` twice, enter a name for your project and click `Finish`. Your project is now ready to host new Ceylon code:

<img src="/images/screenshots/intellij/getting-started/3-project-structure.png" style="box-shadow: 0 0 10px #888;margin-left:10px" width="95%"/>

In the Project view, you can see a few existing files and folders:

* `.ceylon` contains internal configuration that can be reused by the CLI tools, you shouldn't have to modify it directly most of the time.
* `modules` is the output directory where Ceylon modules will be compiled.
* `resource` contains [resources][resources].
* `source` contains [source modules][modules].

To add Ceylon code to this project, you can either put files directly under the `source` folder to add them to the `default` module, or create a new module and add source files to this module. In both cases, `.ceylon` files *must* be in the `source` folder, not directly in the project folder.

* To add a file to the `default` module, right-click on the `source` folder and choose `New > Ceylon File/Declaration`, enter a name (for example `run`) and click `OK`.
* To create a new module, right-click on the `source` folder and choose `New > Ceylon Module`, enter a name like `my.ceylon.example`, adjust the version if you don't like `1.0.0`, set the runnable unit name to something like `run` and click `OK`. New folders will be created (`my/ceylon/example`), along with a module descriptor (`module.ceylon`), a package descriptor (`package.ceylon`) and your runnable unit (`run.ceylon`).

At this point, a tool window titled `Ceylon Problems` should be present in the bottom tool bar, indicating that the IDE is now aware that the project contains Ceylon code and is correctly configured:

<img src="/images/screenshots/intellij/getting-started/4-problems-view.png" style="box-shadow: 0 0 10px #888;margin-left:10px" width="95%"/>

Now that the project is set up, it's time to actually add code :). Open `run.ceylon` and add the following code:

    shared void run() {
        print("hello");
    }

A green arrow will appear in the left gutter, click on that arrow to run or debug the `run` function:

<img src="/images/screenshots/intellij/getting-started/5-run-function.png" style="box-shadow: 0 0 10px #888; display: block; margin: 0 auto;" width="286px"/>

Click on `Run 'run'`, this will automatically create a run configuration, build the project and print `hello`:

<img src="/images/screenshots/intellij/getting-started/6-run-ok.png" style="box-shadow: 0 0 10px #888;margin-left:10px" width="95%"/>

  [resources]: https://ceylon-lang.org/documentation/current/tour/modules/#resources
  [modules]: https://ceylon-lang.org/documentation/current/tour/modules/
