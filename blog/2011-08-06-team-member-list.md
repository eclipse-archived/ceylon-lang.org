---
title: How to add yourself as team member
author: Emmanuel Bernard
layout: blog
tab: blog
tags: [site]
---

Ceylon's website has a [team member list](/community/team).

Adding your bio and photo is simple. create a `FirstnameLastname.md` file under `_data/team`.

This file should contain your name, photo and level as metadata and your biography blurb in the content.

<!-- lang: none -->
    ---
    name: John Doe
    photo: /images/team/JohnDoe.jpg
    level: 1000   
    ---
    John Doe does not work on Ceylon.

    He is however the representative of [...]

    John works for ACME Corp.
    
# Photo

Your photo must be square. A file of 200px by 200px would be best. Place your photo under `/images/team`.

# Level

In order to give proper credit I've introduced the notion of level. Le lower you are, the most important you are (like in SPECTRE).

- level 1: that's founder and fearless leader
- level 10: that's active team member with heavy involvement ( and me of course ;) )
- level 100: casual contributors
- level 1000: retired contributors

# Seeing the result

Once you are satisfied, erase the generated site and run the generation `rm -fR _site ; awestruct -d`. Check it out on the [team page](/community/team).