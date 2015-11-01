---
title:  "Markdown"
date:   2015-04-15 0:00:00
author: Matt Sheehan
categories: journal
---

Header One
======
this is text for header one.

Header Two
----------
this is text for header two.

# Header One #
this is text for header one.

## Header Two ##
this is text for header two.

### Header Three ###
this is text for header three.

#### Header Four ####
this is text for header four.

##### Header Five #####
this is text for header five.

>Markdown should be easier to work with
>
> > -Matt Sheehan

~~~
for (var i = 0; i < 100; i++) {

    // note: in order to indent don't use tabs, use spaces
    print("this should appear as code");

}
~~~

horizontal line

---

1. ordered list
    1. nested
    2. two
2. two
3. three

* unorderd list
    * nested
    * two
* two
* three

definition list
 : dl one
 : dl two

kinds of links ->

<http://mattsheehan.me>
[matt sheehan home page](http://mattsheehan.me)


image and image with link ->

![image]({{ site.url }}/assets/images/oldoldsite.png)

[![image]({{ site.url }}/assets/images/oldsite.png)]({{ site.url }}/assets/images/oldsite.png)


image with link using image definitions ->

[![oldsite]][oldsite]

[oldsite]: {{ site.url }}/assets/images/oldsite.png