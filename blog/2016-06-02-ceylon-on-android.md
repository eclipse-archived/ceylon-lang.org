---
title: Ceylon on Android
author: St&#233;phane &#201;pardaud
layout: blog
unique_id: blogpage
tab: blog
tags: [interop, mobile, android, modularity]
---

In [my last post](/blog/2016/04/20/ceylon-on-mobile/), I explained how you can use Ceylon in Apache Cordova to write applications for
every mobile platform, including iOS and Android. This time, with many apologies for writing it
late (“next week” turned into next month), I will explain how to use the Ceylon IntelliJ plugin
to write native Android applications in Ceylon in Android Studio.

# Getting started with Ceylon on Android Studio

To start writing Ceylon applications in Android Studio, follow these steps:

- [Download Android Studio](https://developer.android.com/studio/index.html)
- Start it
- Create a new application by clicking on `Start a new Android Studio Project`
- You can use these values for `Application name`: `CeylonDemo`
- And for `Company domain`: `android.example.com`
- Next, select an `Empty activity`, with `Activity Name`: `MainActivity`
- Click `Finish` and wait for the project to be created

At this point you have an Android project open, but we still haven't had time to install the Ceylon
plugin, so let's do this right now:
 
- Click on `File > Settings > Plugins > Browse Repositories`
- Then on `Manage Repositories > +`
- Add this repository: `https://downloads.ceylon-lang.org/ide/intellij/development/updatePlugins.xml`
- Now click on `Install Ceylon IDE`

You will likely need to restart Android Studio, so do that.

Next we're going to convert our Android project to a Ceylon Android project:

- In the `Android` view, Right-click on `app > Configure Ceylon in this Module`
- Click `OK` on the resulting configuration dialog

This will set up the Ceylon plugin, and will add most of what you need in your Gradle build to build
Ceylon Android applications. You now have your Ceylon sources in `app/src/main/ceylon` and it includes 
a module descriptor and an empty activity:

<div style="text-align:center;">
<img src="/images/screenshots/blog/2016-06-02-ceylon-on-android/ide.png" 
 style="box-shadow: 0 0 10px #888;margin-left:5px;" width="700px" height="auto"/>
</div>


At the moment, this requires a Ceylon `1.2.3` distribution to build, and since it's not released yet
you're going to have to either [build one yourself](/code/contribute/#contributing_to_the_compiler_backend) 
(just the `Getting the source` part), or 
[download a nightly build](https://ci-ceylon.rhcloud.com/job/ceylon-distribution/).
Once you have it, edit
`app/build.gradle` near then end to add `ceylon > ceylonLocation` and make it point to where you 
installed your distribution (it needs to point to the Ceylon binary, not just the distribution
root): 

<!-- try: -->
<!-- lang: groovy -->
    ceylon {
        // ...
        ceylonLocation ".../ceylon/dist/dist/bin/ceylon"
    }

Make sure you click on `Sync now` to sync your Gradle build.

Now, there's a bug we're in the process of fixing which fails to detect the exact version of the Android
SDK tooling and modules, and so depending on which version of the Android Tools you're using you may have
to sync the imports of `com.android.support:appcompat-v7:23.1.1` in `app/build.gradle` (in `dependencies`)
and in the Ceylon module descriptor in `module.ceylon`. Make sure the Ceylon import version is the same
as the Gradle import version, because the Gradle build is what makes it available to Ceylon, due to Android's
peculiarities.

In order to finish the conversion, make sure you delete the Java activity (since we're going to keep the
Ceylon one), in `Project Files`, delete `app/src/main/java`.

Due to another pending plugin fix, you may have to click on `Tools > Ceylon > Reset Ceylon Model` at this
point so that the Ceylon plugin gets synchronised with all these past changes (don't worry we're fixing
this at the moment).

The good news is we're already able to click on `Run app` and try this in the emulator, but we're going to
make it a little more interesting.

# Customising your Ceylon Android activity

We're going to be displaying a list of Ceylon modules published on [Ceylon Herd](https://herd.ceylon-lang.org),
so we will make use of the Ceylon SDK, and in particular you will have to edit `module.ceylon` to add the following
imports: 

<!-- try: -->
    import ceylon.http.client "1.2.3";
    import ceylon.uri "1.2.3";
    import ceylon.json "1.2.3";
    import ceylon.collection "1.2.3";
    import ceylon.interop.java "1.2.3";

Next, we're going to turn our `MainActivity` into a `ListActivity` and run an asynchronous task to connect to
the Herd REST endpoint, so edit `MainActivity.ceylon` with this:
    
<!-- try: -->
    import android.os { Bundle, AsyncTask }
    import android.app { ListActivity }
    import android.widget { ArrayAdapter, ListAdapter }
    import android.support.v7.app { AppCompatActivity }
    import ceylon.interop.java { createJavaStringArray }
    import java.lang { JString = String }
    import android { AndroidR = R }
    import ceylon.language.meta { modules }
    import ceylon.uri { parseUri = parse }
    import ceylon.http.client { httpGet = get }
    import ceylon.json { parseJson = parse, JsonObject = Object, JsonArray = Array }
    import ceylon.collection { MutableList, LinkedList }
    
    shared class MainActivity() extends ListActivity() {
    
        class LoadModules() extends AsyncTask<String, Nothing, List<String>>() {
            shared actual List<String> doInBackground(String?* uris){
                assert(exists uri = uris.first);
                value response = httpGet(parseUri(uri)).execute();
                value modules = LinkedList<String>();
                assert(is JsonObject json = parseJson(response.contents),
                        is JsonArray results = json["results"]);
                // Iterate modules
                for(res in results) {
                    assert (is JsonObject res); // Get the list of versions
                    assert (is String name = res["module"],
                            is JsonArray versions = res["versions"]);
                    modules.add(name);
                    print(name);
                }
                return modules;
            }
            shared actual void onPostExecute(List<String> result){
                print("Got result: ``result``");
    
                ListAdapter adapter = ArrayAdapter<JString>(outer, AndroidR.Layout.simple_list_item_1,
                    createJavaStringArray(result));
                listAdapter = adapter;
            }
        }
    
        shared actual void onCreate(Bundle savedInstanceState) {
            super.onCreate(savedInstanceState);
            setContentView(R.Layout.activity_main);
    
            LoadModules().execute("https://modules.ceylon-lang.org/api/1/complete-modules?module=ceylon.");
        }
    }

Now edit `app/src/main/res/layout/activity_main.xml` to change the activity type to a list activity:

<!-- try: -->
<!-- lang: xml -->
    <ListView
        android:layout_width="match_parent"
        android:layout_height="match_parent"
        android:id="@android:id/list"/>

And lastly request the `network` permission for your app, since we're hitting a web service, by adding
this to `app/src/main/res/AndroidManifest.xml`:

<!-- try: -->
<!-- lang: xml -->
    <uses-permission android:name="android.permission.INTERNET"/>

That's all you need, now just click on `Run > Run app` and watch your Ceylon application display the
list of modules in the emulator:

<div style="text-align:center;">
<img src="/images/screenshots/blog/2016-06-02-ceylon-on-android/application.png" style="box-shadow: 0 0 10px #888;margin-left:5px;" height="auto"/>
</div>


# Some technical info

The Ceylon IntelliJ plugin has not been released yet, but a preview is forthcoming really soon. You will
see it's already quite advanced when you try this out. Don't hesitate to 
[report any bugs](https://github.com/ceylon/ceylon-ide-intellij/issues/new), or better yet, contribute
fixes :)

Most of it works well enough for Android, except the caveats noted above, and the fact that Android Studio
does not yet recognize Ceylon classes, so they will be marked as errors in the `.xml` files that refer to
them, and when you run your application it will report an error:

<!-- try: -->
<!-- lang: text -->
    Could not identify launch activity: Default Activity not found. Error while Launching activity

It only means it could not start your application, you will have to click on it to start it in the emulator.
But the deployment worked. We're fixing this at the moment, so it will only improve.

If you want to revert to the Ceylon Eclipse IDE to edit your Ceylon Android application, you can, it will
work once you have your project set up with Android Studio. It's much easier to use it to set it up so all
the Gradle config is just right. Once that is done, you can use Eclipse if you want, and use 
`$ ./gradlew assembleDebug` to build your APK.

This work depends on changes we've made in Ceylon 1.2.3 (to be released soon) which adds support for jars
which provide alternate smaller JDKs (such as the Android jar), improvements in modularity so that the
created applications depend on much fewer runtime Ceylon jars than before, fixes in the runtime metamodel
to support Android runtimes, and several other tweaks. I will probably write an account of all that in
a future blog entry.

This work also depends on the [Ceylon Gradle plugin](https://github.com/renatoathaydes/ceylon-gradle-plugin)
written by Renato Athaydes, and on a new [Ceylon Gradle Android plugin](https://github.com/ceylon/ceylon-gradle-android)
which adds support for Ceylon in Android applications. This plugin is by no means finished, and in particular
does not yet support incremental compilation (even though the Ceylon IDE and compiler do). It also does not
yet support the latest Android `Instant Run` feature. Again, please 
[report issues](https://github.com/ceylon/ceylon-gradle-android/issues/new) or better, contribute pull-requests :)
