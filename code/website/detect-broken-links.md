---
title: Add a news to the home page
layout: code
unique_id: codepage
tab: code
author: Emmanuel Bernard
---
# #{page.title}

To detect broken links, you can use [rawler](https://github.com/oscardelben/rawler).

<!-- lang: none -->
    sudo gem install rawler


<!-- lang: none -->
    rawler http://localhost:4242 --wait 0 > broken-link-report.txt
    grep --regexp="200 -" --invert-match broken-link-report.txt