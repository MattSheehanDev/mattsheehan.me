---
title:	"Ruby is Object-Oriented Lisp"
date:	2015-09-22
---

I've fooled around and hankey-pankeyed with lisps for years. I've even wrote a toy [lisp dialect](https://github.com/sheehamj13/mslisp). I've also gotten dirty with Ruby. This site itself is build using Jekyll[^1], a static site generator written with Ruby, and I've wrote a few custom plugins to help my development along.

But I had a shower thought after using the two. Ruby is really just an object-oriented (OO) dialect of lisp[^2]. Sure there are libraries that add OO design principles to lisp, but Ruby takes all of the best parts of lisp and bakes OO constructs directly into it.

I would lump Ruby, lisp, and Javascript into one language family. They're the languages I consider the *fun* programming languages. Sure they're not taken seriously by any of the 'real' developers, but how many times do you get to use the word 'fun' and programming in the same sentence. You might here 'oh, that's interesting' or 'very clever'[^3] said by the real devs, but rarely 'this is fun', and I think that deserves remark.
{: .soliloquy}


The value of everything
{: .primtitle}

Both Ruby and most lisp dialects attribute a value to everything (even if that value is NIL, a keyword that is shared). Undefined does not exist and something never goes uninitialized with some randomness.


The truth of everything
{: .primtitle}

Everything is true, except NIL and FALSE. In boolean conversions, "x" is true, "nil" is true, and NIL is false. If you ever find yourself asking, 'is 0 equivalent to true or false?', the answer is 'is 0 the equivalent of NIL or FALSE? No.', so theres your answer. This makes using boolean logic less painful, you never have to type __if x == nil__ or any equivalent.

__if x *body*__ or the lispy __(if x *body*)__ is good enough.

Operators are functions
{: .primtitle}

Ok, alright already. Operators are basically always functions in every language. But I promise it's different here, they really feel like functions. In lisp you have __(+ 2 2)__, which at any point you can __(set! + (lambda (x y) (- x y)))__, and now addition is subtraction. Since Ruby is just an OO dialect of lisp, this function-ness goes a step further, __2.+(2)__, is the equivalent of 2 + 2, except in the former the +-operator appears as a method on the *Integer Class*[^4].

Everybody should still write 2 + 2 for clarity, but the fact that you can write it alternatively relays my point across.
{: .soliloquy}


Everything is a Function-Object
{: .primtitle}

In lisp everything is a function since there is no OO classes and in Ruby, everything is technically an object, but can be thought of as a function (in the same way as Javascript). Just like in lisp where in the line of code __(defun *name* *body*)__, which defines a new function, __defun__ is really just another function that takes a *name* parameter and a *body* parameter. The same can be said of Ruby. In the line of code __def *name* *body block*__, which defines a new class method, __def__ is really just a function that takes two parameters.

In ruby this also extends to the class access modifiers (public, private, and protected). In the line __private def *method name* *body block*__, __private__ is just a function that takes the return of the function __def__.
{: .soliloquy}


Conventions
{: .primtitle}

And finally the naming conventions, which Ruby has taken from lisp. Functions with question marks at the end usually answer boolean questions about something, while functions with exclamation marks the end usually denote that the function modifies its input.


[^1]: Btw, Jekyll v3.0 is leaps and bounds better than v2.x. Unfortunately, v3.0 is still in beta.

[^2]: I know Ruby looks a lot like Python, I too thought they would be about the same, because of the similar importance attributed to vertical white-space and their bracketless syntax. But those are just syntactical details, and the similarities between the *design* of the language ends there.

[^3]: Other things developers might say are 'Neat!', 'Cool!', and 'Awesome!', as well as any conjugations such as 'Neato!' and 'Coolio!'.

[^4]: Yeah. Even numbers are objects.
