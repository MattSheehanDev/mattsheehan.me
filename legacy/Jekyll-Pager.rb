# Jekyll plugin
# paginates by categories

module Jekyll

  # Generator
  # Creates pages
  class Pager < Generator
    priority :low
    safe true

    def generate(site)
      # get posts per page
      posts_per_page = site.config["pager"] || 5
      raise "Pager error: posts per page must be at least 1" if posts_per_page < 1

      # get category to parse
      category = site.config["pager_category"]

      # site.categories.each_key do |key|
      #   puts key
      # end
      # site.collections.each_key do |key|
      #   puts key
      # end
      # raise "Pager error: category doesn't exist on site" if !category || !site.categories.has_key?(category)
      # raise "Pager error: category doesn't exist on site" if !category || !site.categories.journal

      # get path where we are going to 
      # put pages
      config_dir = site.config["pager_path"] || category
      
      base_dir = nil	# ex. journal
      list_dir = nil	# ex. page

      config_dir.split(/\/+/).each do |b|
        if base_dir == nil
          base_dir = b
        elsif list_dir == nil
          list_dir = b
        end
      end
      
      if !base_dir then base_dir = category end
      if !list_dir then list_dir = "page" end

      puts base_dir
      puts list_dir


      # the first page goes in the root site directory
      index = 1
      list = PagerList.new(site, "/", index)

      # posts = site.categories[category]
      # posts = site.collections[category].docs
      # posts.each_index do |i|
      posts = site.posts.reverse
      posts.each_index do |i|
        post = posts[i]
        list.push(post)

        if(posts.length == i + 1)
          # this is the last page list
          list.create()

          # we've hit our allotted posts limit
        elsif list.posts.length == posts_per_page
          # create list page
          list.create()

          # next page index and directory
          index += 1
          dir = File.join("/", base_dir, "#{list_dir}#{index}")
          puts dir
          # temporary variables while  pages are linked up
          prev_list = list
          next_list = PagerList.new(site, dir, index)

          # set next page on prev list
          prev_list.next_page = next_list
          prev_list.next_page_path = next_list.path

          # set prev page on next list
          next_list.prev_page = prev_list
          next_list.prev_page_path = prev_list.path
          
          # set list to next list
          list = next_list
        end
      end
    end
    
  end



  class PagerList

    attr_accessor :posts, :index, :path, :next_page, :prev_page, 
    :prev_page_path, :next_page_path


    def initialize(site, dir, index)
      @site = site
      @path = dir
      @index = index
      @posts = Array.new
			
      @next_page = nil
      @next_page_path = nil
      @prev_page = nil
      @prev_page_path = nil
    end
    
    
    def create()
      @site.pages << PagerPage.new(@site, @site.source, @path, self)
    end
    
    def push(post)
      @posts.push(post)
    end

    # exposes properties to liquid template
    # used by pages
    def to_liquid()
			{
        "posts" => @posts,
        "index" => @index,
        "next_page" => @next_page,
        "next_page_path" => @next_page_path,
        "prev_page" => @prev_page,
        "prev_page_path" => @prev_page_path
      }
    end
    
  end



  class PagerPage < Page
    def initialize(site, base, dir, list)
      @site = site
      @base = base
      @dir = dir
      @name = "index.html"
      @pager = list

      # since we're not calling super
      # init ourselves
      self.process(@name)

      # this reads the template
      # that the post is going to use
      self.read_yaml(base, "index.html")

      # add pager data to page
      self.data["pager"] = list
    end
  end

  
end
