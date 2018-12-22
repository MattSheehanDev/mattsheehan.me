# Jekyll plugin for generating Windows 8.1 start screen live tiles
#
# Usage: place this file in the _plugins directory and set the required configuration
#        attributes in the _config.yml file
#
# Uses the following attributes in _config.yml:
#   ie_category:   - (optional) poll only a specific category of posts
#   ie_frequency:  - (optional) the frequency of site polling. Options are {30,60,360,720,1440}. Default is 1440 (1 day)
#   ie_tile_color: - (optional) the color of the windows 8 pinned background tile
#   ie_tile_small: - location of small tile image (For more information of tile sizes visit http://msdn.microsoft.com/en-us/library/dn455106(v=vs.85).aspx)
#   ie_tile_medium - location of medium tile image
#   ie_tile_wide   - location of wide tile image
#   ie_tile_large  - location of large tile image

#
# Author: Matt Sheehan <sheehamj@mountunion.edu>
# Site: http://mattsheehan.me
# Source: http://github.com/
#
# Distributed under the MIT license
# Copyright Matt Sheehan 2014

require 'builder'


Jekyll::Hooks.register :site, :post_write do |site|
  # create templates directory
  templates_dir = File.join(site.dest, "/ietemplates/")
  FileUtils.mkdir_p(templates_dir)

  # create tile config file
  write_config(site, File.join(templates_dir, "ieconfig.xml"))

  # create tile poll files
  category = site.config["ie_category"]
  posts = !category ? site.posts.docs : site.categories.has_key?(category) ? site.categories[category].docs : site.posts.docs

  count = [posts.length, 4].min   # create at most 4 polling files

  posts.reverse[0..count].each_with_index do |post, index|
    write_poll_file(site, post, File.join(templates_dir, "poll#{index+1}.xml"))
  end
end


def write_config(site, filename)
  # configs
  tile_color = site.config["ie_tile_color"] || "#000000"
  tile_small = site.config["ie_tile_small"]
  tile_medium = site.config["ie_tile_medium"]
  tile_wide = site.config["ie_tile_wide"]
  tile_large = site.config["ie_tile_large"]

  frequency = site.config["ie_frequency"] || 1440
  raise "frequency must be either 30, 60, 360, 720, 1440" unless [30,60,360,720,1440].include?(frequency)


  # build xml config
  xml = Builder::XmlMarkup.new( :indent=>2)
  xml.instruct! :xml, :encoding=>"utf-8"

  xml.browserconfig do |config|
    config.msapplication do |app|
      app.tile do |tile|
        tile.tag!("square70x70logo", "src"=>"#{tile_small}")
        tile.tag!("square150x150logo", "src"=>"#{tile_medium}")
        tile.tag!("wide310x150logo", "src"=>"#{tile_wide}")
        tile.tag!("square310x310logo", "src"=>"#{tile_large}")
        tile.tag!("TileColor", "#{tile_color}")
      end
      app.notification do |n|
        n.tag!("polling-uri", "src"=>"/ietemplates/poll1.xml")
        n.tag!("polling-uri2", "src"=>"/ietemplates/poll2.xml")
        n.tag!("polling-uri3", "src"=>"/ietemplates/poll3.xml")
        n.tag!("polling-uri4", "src"=>"/ietemplates/poll4.xml")
        n.tag!("polling-uri5", "src"=>"/ietemplates/poll5.xml")
        n.tag!("frequency", "#{frequency}")
        n.tag!("cycle", "1")
      end
    end
  end

  # write file
  File.open(filename, "w") { |f| f.write(xml.target!) }
end


def write_poll_file(site, post, filename)
  # Build xml tile templates
  xml = Builder::XmlMarkup.new( :indent => 2)
  xml.instruct! :xml, :encoding => "utf-8"

  xml.tile do |tile|
    tile.visual("lang"=>"en-US", "version"=>"2") do |v|
      v.binding("template"=>"TileSquare150x150Text04", "branding"=>"logo", "fallback"=>"TileSquareImage") do |b|
        b.tag!("text", post.data["title"], "id"=>"1")
      end
      v.binding("template"=>"TileWide310x150Text03", "branding"=>"logo", "fallback"=>"TileWideImage") do |b|
        b.tag!("text", post.data["title"], "id"=>"1")
      end
      v.binding("template"=>"TileSquare310x310TextList02", "branding"=>"logo", "fallback"=>"TileWideText09") do |b|
        b.tag!("text", post.data["title"], "id"=>"1")
        b.tag!("text", shorten(strip(post.content)),"id"=>"2")
        b.tag!("text", "#{post.date.month}-#{post.date.day}-#{post.date.year}", "id"=>"3")
      end
    end
  end

  # write xml file
  File.open(filename, "w") { |f| f.write(xml.target!) }
end


# Shortens string and adds trailing ellipsis
def shorten(str, count = 30)
  if str.length >= count
    return str[0, count] << "..."
  end
  return str
end

# Strips html tags (not the best)
def strip(string)
  string.gsub(/<[^>]*>/, "")
end
