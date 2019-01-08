---
title: "Note on Jekyll Plugins"
date: 2015-04-21
---

There's not a lot of really good documentation on how to roll your own [Jekyll](http://jekyllrb.com) plugins, and most of the plugins that currently exist aren't very good. That includes a few of my first attempts. Through some trial and error, [Stackoverflow](http://stackoverflow.com) searching, and [source code](https://github.com/jekyll/jekyll) browsing, I've managed to gather a few 'best practices'. Especially for writing Generators, the most popular and used type.

There are four types of [plugins](http://jekyllrb.com/docs/plugins/), Generators, Converters, Commands and Tags. This post is about generators[^1].
{: .soliloquy }

There are four important things you should know about generators first.

* They are invoked before the site is built, but after it is initialized, and usually directly copied to the _site folder.
* They must inherit from Jekyll's base Generator class.
* Like all other plugins, they belong in your _plugins folder.
* They're often written wrong, or at least not optimal, and most of the generators you steal will clutter up your directory.

Generator's only have one important function to know which is `generate`{: .highlight }, and is passed one argument `site`{: highlight }.

{% highlight ruby %}
module Jekyll
    class MyGenerator < Generator
        def generate(site)
            # do stuff here
        end
    end
end
{% endhighlight %}

There's two important properties of `site` that you should learn first, those being the array `static_files` and the hash map `pages`. If you want your generator to create files that need to be converted, therefore have YAML front matter, you should add your page to `site.pages`.

{% highlight ruby %}
module Jekyll
    class MyGenerator < Generator
        def generate(site)
            site.pages << MyPage.new(site, site.source, 'some/directory', 'file.html')
        end
    end

    class MyPage < Page
        def initialize(site, base, dir, name)
            super(site, base, dir, name)
        end
    end
end
{% endhighlight %}

I created a custom page class that inherits from Jekyll's base `Page` class. That's not necessary in this example if you're not doing any custom page work, but that will be important later.

What I'm more concerned about is `static_files`. These do not have YAML front matter and do no post-processing. But the problem with static files you see, is if you create static files in your generator and add them to the sites static_files array, those files would first get created in your project directory and then copied into your site's root folder, which is usually _site.

Do you see the problem? There are duplicate files being created then immediately copied and cluttering up your source directory. Since files created at build shouldn't be added to source control you then end up ignoring those created directories and files in your .gitignore file. I know this isn't super performant code, so it's not really a big deal. But sometimes it's fun to just be clever and see how much better you can do.

There's actually another secret that Jekyll hides that let us take advantage of waiting to write our static files until after the site is build and therefore only write it once into your site root folder. The base `Page` class used above actually has an important method called 'write', which is passed a `dest' string. 

When write is invoked is when we should actually be writing all of our static files. So our end code would look something like below.

{% highlight ruby %}
class MyGenerator < Generator
    def generate(site)
        # add our pages here to static files array
        site.static_files << MyPage.new(site, site.source, 'some/directory', 'file.html')
    end
end

class MyPage < StaticFile
    def initialize(site, base, dir, name)
        super(site, base, dir, name)
    end

    def write(dest)
        # write is called after _site directory is built
        # lets write our static files once here
        path = File.join(dest, base, @dir)
        FileUtils.mkdir_p(path)

        # build up your file...
        ...

        # write file
        File.open(File.join(path, @name), 'w') { |f| f.write(file) }
    end
end
{% endhighlight %}

The secret is overloading the pages write method, which is usually invoked to just copy static files[^2].

You should also notice that MyPage is inheriting from StaticFile this time instead of Page. And remember to put your class's under the Jekyll namespace.
{: .soliloquy }

[^1]: This is probably the first post I've written in two years with any meat on it. Not good meat mind you, think more pink slime.
[^2]: <del>I should link these notes in the post.</del> Done.