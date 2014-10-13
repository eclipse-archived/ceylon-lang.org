---
title: Typesafe APIs for the browser
author: Gavin King
layout: blog
unique_id: blogpage
tab: blog
tags:
---

A new feature in Ceylon 1.1, that I've not blogged about before, is
_dynamic interfaces_. This was something that Enrique and I worked 
on together with Corbin Uselton, one of our GSoC students.

Ordinarily, when we interact with JavaScript objects, we do it from
within a `dynamic` block, where Ceylon's usual scrupulous typechecking
is suppressed. The problem with this approach is that if it's an API
I use regularly, my IDE can't help me get remember the names and 
signatures of all the operations of the API.  

Dynamic interfaces make it possible to ascribe static types to an 
untyped JavaScript API. For example, we could write a dynamic 
interface for the HTML 5 `CanvasRenderingContext2D` like this:

<!-- try-post:

    CanvasRenderingContext2D ctx;
    
    dynamic {
        if (exists canvas = document.getElementById("lifegrid")) {
            canvas.parentNode.removeChild(canvas);
        }
        
        dynamic canvas = document.createElement("canvas");
        canvas.setAttribute("id", "lifegrid");
        canvas.setAttribute("width", 300);
        canvas.setAttribute("height", 120);
        dynamic corePage = document.getElementById("core-page");
        corePage.insertBefore(canvas, corePage.childNodes[3]);
        ctx = canvas.getContext("2d");
    }
    
    ctx.fillStyle = "navy";
    ctx.fillRect(50, 50, 235, 60);
    ctx.beginPath();
    ctx.moveTo(100,50);
    ctx.lineTo(60,5);
    ctx.lineTo(75,75);
    ctx.fill();
    ctx.fillStyle = "orange";
    ctx.font = "40px PT Sans";
    ctx.fillText("Hello world!", 60, 95);
-->
    dynamic CanvasRenderingContext2D {
        shared formal variable String|CanvasGradient|CanvasPattern fillStyle;
        shared formal variable String font;
        
        shared formal void beginPath();
        shared formal void closePath();
        
        shared formal void moveTo(Integer x, Integer y);
        shared formal void lineTo(Integer x, Integer y);
        
        shared formal void fill();
        shared formal void stroke();
        
        shared formal void fillText(String text, Integer x, Integer y, Integer maxWidth=-1);
        
        shared formal void arc(Integer x, Integer y, Integer radius, Float startAngle, Float endAngle, Boolean anticlockwise);
        shared formal void arcTo(Integer x1, Integer y1, Integer x2, Float y2, Integer radius);
        
        shared formal void bezierCurveTo(Integer cp1x, Integer cp1y, Integer cp2x, Float cp2y, Integer x, Integer y);
        
        shared formal void strokeRect(Integer x, Integer y, Integer width, Integer height);
        shared formal void fillRect(Integer x, Integer y, Integer width, Integer height);
        shared formal void clearRect(Integer x, Integer y, Integer width, Integer height);
        
        shared formal CanvasGradient createLinearGradient(Integer x0, Integer y0, Integer x1, Integer y1);
        shared formal CanvasGradient createRadialGradient(Integer x0, Integer y0, Integer r0, Integer x1, Integer y1, Integer r1);
        shared formal CanvasPattern createPattern(dynamic image, String repetition);
        
        //TODO: more operations!!
    }
    
    dynamic CanvasGradient {
        shared formal void addColorStop(Integer offset, String color);
    }
    
    dynamic CanvasPattern {
        //todo
    }

Now, if we assign an instanceof of JavaScript's `CanvasRenderingContext2D` to this interface
type, we won't need to be inside a `dynamic` block when we call its methods. Try it!

<!-- try:
    dynamic CanvasRenderingContext2D {
        shared formal variable String|CanvasGradient|CanvasPattern fillStyle;
        shared formal variable String font;
        
        shared formal void beginPath();
        shared formal void closePath();
        
        shared formal void moveTo(Integer x, Integer y);
        shared formal void lineTo(Integer x, Integer y);
        
        shared formal void fill();
        shared formal void stroke();
        
        shared formal void fillText(String text, Integer x, Integer y, Integer maxWidth=-1);
        
        shared formal void arc(Integer x, Integer y, Integer radius, Float startAngle, Float endAngle, Boolean anticlockwise);
        shared formal void arcTo(Integer x1, Integer y1, Integer x2, Float y2, Integer radius);
        
        shared formal void bezierCurveTo(Integer cp1x, Integer cp1y, Integer cp2x, Float cp2y, Integer x, Integer y);
        
        shared formal void strokeRect(Integer x, Integer y, Integer width, Integer height);
        shared formal void fillRect(Integer x, Integer y, Integer width, Integer height);
        shared formal void clearRect(Integer x, Integer y, Integer width, Integer height);
        
        shared formal CanvasGradient createLinearGradient(Integer x0, Integer y0, Integer x1, Integer y1);
        shared formal CanvasGradient createRadialGradient(Integer x0, Integer y0, Integer r0, Integer x1, Integer y1, Integer r1);
        shared formal CanvasPattern createPattern(dynamic image, String repetition);
        
        //TODO: more operations!!
    }
    
    dynamic CanvasGradient {
        shared formal void addColorStop(Integer offset, String color);
    }
    
    dynamic CanvasPattern {
        //todo
    }

    CanvasRenderingContext2D ctx;
    
    dynamic {
        if (exists canvas = document.getElementById("lifegrid")) {
            canvas.parentNode.removeChild(canvas);
        }
        
        dynamic canvas = document.createElement("canvas");
        canvas.setAttribute("id", "lifegrid");
        canvas.setAttribute("width", 300);
        canvas.setAttribute("height", 120);
        dynamic corePage = document.getElementById("core-page");
        corePage.insertBefore(canvas, corePage.childNodes[3]);
        ctx = canvas.getContext("2d");
    }
    
    ctx.fillStyle = "navy";
    ctx.fillRect(50, 50, 235, 60);
    ctx.beginPath();
    ctx.moveTo(100,50);
    ctx.lineTo(60,5);
    ctx.lineTo(75,75);
    ctx.fill();
    ctx.fillStyle = "orange";
    ctx.font = "40px PT Sans";
    ctx.fillText("Hello world!", 60, 95);
-->
    CanvasRenderingContext2D ctx;
    
    dynamic {
        ctx = ... ;
    }
    
    ctx.fillStyle = "navy";
    ctx.fillRect(50, 50, 235, 60);
    ctx.beginPath();
    ctx.moveTo(100,50);
    ctx.lineTo(60,5);
    ctx.lineTo(75,75);
    ctx.fill();
    ctx.fillStyle = "orange";
    ctx.font = "40px PT Sans";
    ctx.fillText("Hello world!", 60, 95);


Notice that we don't need to ascribe an explicit type to *every*
operation of the interface. We can leave some methods, or even
just some parameters of a method untyped, by declaring them
`dynamic`. Such operations may only be called from within a 
`dynamic` block, however.

A word of caution: dynamic interfaces are a convenient fiction.
They can help make it easier to work with an API in your IDE,
but at runtime there is nothing Ceylon can do to ensure that
the object you assign to the dynamic interface type _actually
implements the operations_ you've ascribed to it. 