---
title: The Ceylon Herd has been unleashed
author: St&eacute;phane &Eacute;pardaud
layout: blog
unique_id: blogpage
tab: blog
tags: [herd]
---
If there´s one thing the whole Ceylon team has in common it´s that we´re _pragmatists_. We have a ton of ideas
of how we can make the programmer´s life better with Ceylon, and we try to do it whenever we can. In fact, we have
so many ideas that it´s hard to bring them all to fruition. With people such as Gavin and I in the team, being very
involved in Web Frameworks, I can tell you that among the many things we want to do with Ceylon, the only thing
holding us back from writing an excellent Web Framework for Ceylon (or adapting one) is that we simply have more
urgent things to fix right now.

## Why we needed a new module repository

One of those urgent things to fix, we quickly realised, was to have a better, leaner, nicer, friendlier module
repository for Ceylon modules. You probably know by now that all the Ceylon tools can already talk to module
repositories, local or remote. By _talk_ I mean, _use_ and _publish to_.

We added support for [WebDAV](http://en.wikipedia.org/wiki/WebDAV) 
from the start, and then we tried it and found that it was actually hard for people
to set up WebDAV on their server to set up their own repo. Because that´s the thing with open-source: we´re not
trying to solve the repo problem just for _us_, but also for all our users. We want them to be setting up repos
as easily as we do.

We went and looked at the existing module repositories like Perl´s [CPAN](http://www.cpan.org), 
Ruby´s [Gems](http://rubygems.org), Maven´s [Nexus](http://www.sonatype.org/nexus), or
Play´s [modules](http://www.playframework.org/modules). 
We liked what we saw in some of them, but what we noticed was that none of them had all the features
we wanted for a great repository experience. Probably the sum of them all would be the Best Repo In The World, but
truth is, it´d probably be a spaghetti monster too.

We wanted something that looks nice for consumers, with a friendly, clear and intuitive interface, but at the same
time we wanted to make it just as easy for producers, with a clear path to publish modules, and at the same time
a _collaborative_ aspect, such as found in [Github](http://github.com) that we like so much.

## Ceylon Herd

So we spent a couple of days banging code together and came up with the following quite impressive list of
features for consumers:

- Browse repository as file system
- Browse module list
- Search for modules
- Browse module documentation
- View module information, such as dependencies, docs, source
- Links from modules to file system view and back
- Feeds to catch up with new modules, new module versions or modules published by user
- View user activity (list of published modules)

And for producers:

- Public registration
- Integrated interactive project claim (more on that later)
- Upload area: to create private staging repos where you upload your modules
- Uploaded modules are checked by our system to help you:
    - Module paths
    - Module ownership
    - Duplicate module detection
    - SHA1 Signatures verification
    - API docs presence verification
    - Source code presence verification
    - Dependencies check
    - Many other checks
- You can upload multiple modules at once
- Upload using the Ceylon tools or the website, individual artifacts or with a zipped repo
- Publish your modules once all verifications pass
- Edit your module information
- Grant publishing permissions to your colleagues
- Transfer module ownership

You´re not dreaming, we did all of this, and a lot more under the hood as well as in the
UI, to make sure newcomers are not overwhelmed or abandoned, to make sure everyone feels
right at home in [Ceylon Herd][herd], our open-source Ceylon module repository.

You heard that right: today we unveal our official module repository, called Ceylon Herd,
which is where we are (we as in me, you, everyone) going to publish our Ceylon modules for
all to use. And because we´re open-source guys, and we don´t want to lock people into a 
fenced-wall service, we´re making Ceylon Herd available as [Free Software][source], so that everyone
can not only contribute to make it better, but use it privately or publicly.

Our version of Ceylon Herd, running at `modules.ceylon-lang.org`, 
will be the official place to get official Ceylon modules, as
well as the central place to get third-party modules, as long as they are open-source. We´re
still working out the details of the hosting policy, so we´ve disabled registration for now,
which means that for you guys it is purely read-only until we open it up completely, but rest
assured that will happen as soon as we can, so you can start sharing too.

Meanwhile you can start consuming the few modules we put there to get you started.

## Who can publish what?

Because we plan to use Ceylon Herd as the official Ceylon module repository, we need to make
sure that the modules published there are legit and functional. If John Doe can come in
and start publishing modules he doesn´t own, or participate in, or represent, then that´s
just bad for our repository. John Doe is free to use another Ceylon Herd instance, but we´re
going to be careful who we let publish in `modules.ceylon-lang.org`.

So our solution is called _project claims_: when you have registered on Ceylon Herd, you can
_claim_ a project (essentially a module name), and you explain its license, point to its home
page, who you are and why we need it in Ceylon Herd. We´re immediately notified and start
checking up on the project, verify that you are who you say you are, and that you should indeed
be allowed to publish on behalf of that project.

This verification is an interactive process, we may ask you questions, via comments on the claim,
which you get notified about and can answer. As soon as we´ve made up our mind, we´ll either confirm
your claim, or reject it. If it is rejected, don´t be afraid to re-claim it if you feel we were
wrong, we can discuss it again, especially if you have new and good evidence. We´re only trying to
help authenticate module publishers, not control what goes in or not (though it has to be open-source).

Once your claim is verified, you are free to publish as many versions of your module as you want,
as well as delegate publishing of that module to other Ceylon Herd users (your colleagues, project
buddies, spouse or kids for the luckier). At any moment you can transfer project ownership to another
Ceylon Herd user.

If you think this is not good enough, please let us know.

## OK, enough with the prep talk, how do I get started? 

Ceylon Herd is [available here][herd], we can help you [get started][get-started], 
and you can even [download its source][source]
code to run it where you want and [improve it][issues]. Use, follow, share, contribute, have fun!

[herd]: http://modules.ceylon-lang.org
[get-started]: http://modules.ceylon-lang.org/usage
[source]: https://github.com/ceylon/ceylon-herd
[issues]: https://github.com/ceylon/ceylon-herd/issues