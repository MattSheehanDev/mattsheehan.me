# Jekyll plugin for generating Rss feed
#
# Usage: place this file in the _plugins directory and set the required configuration
#        attributes in the _config.yml file
#
# Uses the following attributes in _config.yml:
#   rss_title 	 	- (optional) the feed title
#   rss_author 	 	- (optional) the feed author
#   rss_description - (optional) short description of the site
#   rss_link		- (optional) url of the site
#
# Author: Matt Sheehan <sheehamj@mountunion.edu>
# Site: http://mattsheehan.me
# Source: http://github.com/
#
# Distributed under the MIT license
# Copyright Matt Sheehan 2014


Jekyll::Hooks.register :site, :post_write do |site|
	require 'rss'

	feed_dir = File.join(site.dest, '/feeds/')
	FileUtils.mkdir_p(feed_dir)

	# configs
	title = site.config["rss_title"] || ""
	author = site.config["rss_author"] || ""
	description = site.config["rss_description"] || ""
	link = site.config["rss_link"] || ""
	date = site.posts.docs.map { |post| post.date }.max

	# write rss
	rss = RSS::Maker.make("2.0") do |rss|
		rss.channel.title = title
		rss.channel.link = link
		rss.channel.description = description
		rss.channel.author = author
		rss.channel.updated = date
		rss.channel.copyright = date.year

		count = [site.posts.docs.count, 20].min

		site.posts.docs.reverse[0..count].each do |post|
			# post.render(site.layouts, site.site_payload)
			rss.items.new_item do |item|
				item.title = post.data[:title]
				item.link = "#{link}#{post.url}"
				item.description = post.content
				item.updated = post.date
				item.guid.content = "#{link}#{post.url}"
			end
		end
	end

	# write file
	filepath = File.join(feed_dir, 'rss.xml')
	File.open(filepath, "w") { |f| f.write(rss) }
end
