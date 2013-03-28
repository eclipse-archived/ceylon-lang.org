---
title: Ceylon Date/Time api
author: Roland Tepp
layout: blog
unique_id: blogpage
tab: blog
tags: [progress, datetime, sdk]
---

Ceylon Date/Time api
====================

Proper date and time manipulation is an important part of any number of real world applications. From recording timestamps of events to calculating monthly interest amount of your loan payment schedule, to figuring out if someone is of legal age to enter your site. All of these have to deal with date and time

The new [date and time API][ceylon.time] introduced in Ceylon M5 SDK is roughly inspired by and modeled after very popular [JodaTime]  (and it's successor [JSR 310]) date and time api for Java, so if You've used one of these, the api will likely feel familiar.

[JodaTime]: http://joda-time.sourceforge.net/
[JSR 310]: http://openjdk.java.net/projects/threeten/
[ceylon.time]: http://modules.ceylon-lang.org/modules/ceylon.time/0.5

Getting current instant and measuring the duration between two instants is really easy an intuitive:
    
    Instant start = now();
    Pi pi = Pi();
    for (n in 0..10000){
        process.write(pi.next().string);
        if (n == 0) process.write(".");
    }
    Duration duration =  start.durationTo( now() );
    print("Calculated 10000 digits of pi in `` duration ``.");

An `Instant` is a _machine representation_ of time. It is essentially a point on a one-dimensional continuous scale of time.

You can always turn an `Instant` into the equivalent human representation:

    Instant instant = now();
    Time timeOfDay = instant.time();
    Date today = instant.date();
    DateTime thisMoment = instant.dateTime();

Quite often, all you need or have is a _date_ and having to deal with time attached to a date, is just extra work (yes, `java.util.Date` and `java.util.Calendar`, I am looking at you!).

Here is an example how you would find out last date an item can be returned to the store for refund (14 days since since date of purchase):

    Date refundableUntil(Date purchasedOn, 
                         {Date*} publicHolidays = {}) {
        variable Date refundable = purchasedOn.plus(Period{ days=14; });
        while ( refundable in publicHolidays
                || refundable.dayOfWeek in {saturday, sunday} ) {
            refundable++;
        }
        return refundable;
    }

Things like open hours of a store, or timetable of a public transportation schedule are ideal use cases for `Time` type.

    if (time(13, 0) <= now.time() <= time(14, 0)) {
        print("I'm on a lunch break! Call back in an hour (``now().time().plusHours(1)``).");
    }

`DateTime` type does not include time zone data, so it is useful in situations where time zone is not important or not needed. For example if you need to compare or record relative time of events in different time zones or when you only operate on local time.

    DateTime sunrise = dateTime(2013, march, 26, 06, 05);
    DateTime sunset = dateTime(2013, march, 26, 18, 50);
    if (sunrise < now().dateTime() < sunset) {
        print("There is light!");
    }

Just as Ceylon, the language itself, `ceylon.time` is a work in progress and there are still some major features missing in the 0.5 version, that are planned for the next few releases of the language and sdk.

Among the stuff coming up next in `ceylon.time` is time zone support, date and time ranges and iteration.

Check it out and give us feedback.