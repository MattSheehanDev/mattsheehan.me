---
title:  "Site Updates"
date:   2014-04-19 0:04:28
author: Matt Sheehan
---

I've made a few updates to the site. Most of which will probably go unnoticed unless you have an extroardinary attention to detail.

First, you can now pin this site to your start menu on Windows 8.1 if you are using Internet Explorer 11 in Windows 8 mode. Not only will you get a nice choice of four sizes of icons to choose from but you'll also get live tile updates so you can get a gist of what the top posts are. These live updates are being pulled from a list of xml files that are auto generated with this [Jekyll plugin](https://github.com/sheehamj13/jekyll-live-tiles) that I wrote over the weekend. It can also be found [on the Jekyll site here](http://jekyllrb.com/docs/plugins/) about halfway down the page under Available Plugins then Generators.

To pin this site to your homescreen open up IE11 in Windows 8 mode and click favorites (the star), then pin (the pushpin).

If you have an iPhone you can pin the site to your home screen and also be greeted with new icons (my initials) as well. I found a really easy way to export different size png's from inkscape with a blue (#497bad, also found all over this site) background.

The RSS feed is now auto generated with a [Jekyll plugin](https://github.com/sheehamj13/jekyll-rss-feed) that I wrote this weekend as well. Both plugins are easy to use if you have a Jekyll powered site. Just clone the repos and put the ruby scripts in your <code>_plugins</code> folder. The RSS url also changed. It's now http://mattsheehan.me/feeds/rss.xml. So update your rss subscriber to keep getting updates.

I also cleaned up the github repo this site is hosted on as well, so looking at the repo shouldn't be such a mess. The repo the site is hosted on has also changed. Instead of using Githubs project pages (gh-pages orphan branches), everything's now hosted using Githubs user pages under the sheehamj13.github.io repo.