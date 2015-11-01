---
title: "Processing and parabola's"
processing: true
---

This weekend I was playing with [processing](https://processing.org/) after coming working through the first lesson of [Pixar in a Box](https://www.khanacademy.org/partner-content/pixar) on [Khan Academy](https://khanacademy.org).

There's also this super neat javascript library that renders your processing scripts on an html canvas element called [processing.js](http://processingjs.org/). Which makes processing not only a fun tool for your computer, but lets you make fun projects for the web as well[^1].


To summarize, Pixar in a Box begins with environment modeling. Rendering a blade of grass is given as an example and is described in terms of a parabola, or more specifically a parabolic arc. The first part is an intro with examples, and for those that want to venture further, can venture into the second part which explains the algebra.

I decided it'd be fun and more concrete to implement what I learned myself, so I dug up processing again and had fun making this! I'd check out khan academy if you wanted to know more, since it would be explained better there than I could explain myself.

If you want to view the demo (below), make sure you navigate to the full post page by clicking the title above (if you haven't already).

<canvas width="100%" height="100%" data-processing-sources="{{ site.url }}/projects/parabolic_arc/parabolic_arc.pde {{ site.url }}/projects/parabolic_arc/parabolic_controls.pde">
</canvas>


[^1]: It's much easier working with processing than any specific javascript library for rendering to a canvas. I guess that's [the pro's and con's of working with a domain specific language](https://en.wikipedia.org/wiki/The_Pros_and_Cons_of_Hitch_Hiking).