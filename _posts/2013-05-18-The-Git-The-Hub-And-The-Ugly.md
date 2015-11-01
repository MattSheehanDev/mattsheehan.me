---
title:  "The Git, The Hub, And The Ugly"
date:   2013-05-18 0:18:15
author: Matt Sheehan
---


It's funny how your opinion's can change. I didn't like GitHub when I first signed up for a few good reasons.

* It sucked on Windows.
* There was no single good source about how to use GitHub on Linux

Even the Github help pages weren't that useful unless you manage to piecemeal it all together (which I eventually did).
I must admit though, now that I know how to use GitHub on Linux, It's amazing. It's seriously one of the most useful tools that a software developer could use for version control and _forking_ others code. I am a big fan of this open source movement. 
So in order to help all you wary travellers out there who want to become a part of this, let me blaze a single trail here where you can refer back to the basics of using the git command and GitHub.

Before we start make sure you have git installed. If your using a Debian based operating system it might already be installed.. I'm using Mint which you can check out [here](http://www.linuxmint.com/). If not, the easiest way to do this is to type the following into the terminal.

~~~
    apt-get install git
~~~

Then to configure it type

~~~
    git config --global user.name [usernamehere]
~~~

and

~~~
    git config --global user.email [emailhere]
~~~

The first line installs git and the next two just configure the settings to remember your name and email.

Now is when we can actually go ahead and start using GitHub. Login and create a new repository.

Once a new repository is created, clone that repository onto your computer by entering

~~~
    git clone https://repository_address_here
~~~

into the terminal. 

CD into your new repository

~~~
   cd ~/new_repository
~~~

Now you can add things to that directory from your project. Once new files are added to the directory and your ready to upload type

~~~
    git add --all
~~~

which will prepare GitHub for all the new files you've just added.

Next you want to commit your updated directory, type

~~~
    git commit -m "Commit Message"
~~~

Finally push ( _upload_ ) the directory back to GitHub

~~~
    git push origin master
~~~

If you're pushing to a different branch, like [Github Pages](https://help.github.com/categories/20/articles), then just type

~~~
    git push origin [branchname]
~~~~

That's really all you need to know to get started. So go get coding, you could even fork this blog from my github page (that's like creating a new repository).

##### Word of the day: __pithy__ #####

##### Quote of the day: #####

>Either write something worth reading or do something worth writing.
>
> > -Benjamin Franklin