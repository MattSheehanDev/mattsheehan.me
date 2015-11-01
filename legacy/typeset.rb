# 

Jekyll::Hooks.register :page, :post_write do |doc|
  if File.extname(doc.name) == ".html"
  src = File.join(doc.site.dest, doc.dir, doc.name)
  dest = File.join(doc.site.dest, doc.dir, doc.name)
  typeset = File.join(doc.site.source, "/Typeset/src/cmd.js")
  puts typeset
  `node #{typeset} #{src} -o #{dest}`
  end
end

# module Jekyll

#   class Site
#     alias site_process process

#     def process
#       site_process

#       puts "List of html pages"
#       self.pages.each do |page|
#         puts page.name
#       end

#       puts "List of posts"
#       self.posts.each do |post|
#         puts post.name
#       end
# x
#       # puts "List of static files"
#       # self.collections.each do |label, collection|
#       #   self.collection.docs.each do |document|
#       #     puts "test"
#       #     puts document.output
#       #   end
#       # end
#     end

#    end

# end
