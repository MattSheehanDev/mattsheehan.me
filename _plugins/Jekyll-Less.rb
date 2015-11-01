# Converts less files to css
#
# Uses the following properties in _config.yaml
# => lessc: path of less compiler, can be ommitted if less if included in the sys env path
# => css_dest: directory where all css output will write to
#
# Notes
# => css files will have the same root name as their less counterparts


Jekyll::Hooks.register :site, :post_write do |site|
  statics = site.static_files
  config = site.config

  lessc = config['lessc'] || 'lessc'
  css_dest = config['css_dest'] || '/'

  raise "Missing 'lessc' path in site configuration" if not lessc


  statics.delete_if do |file|
    next if not File.extname(file.path) == '.less'

    less_name = File.basename(file.path)

    css_dir = File.join(site.dest, css_dest)
    css_name = less_name.gsub(/\.less$/i, ".css")
    css_path = File.join(css_dir, css_name)

    FileUtils.mkdir_p(css_dir);
    system("#{lessc} #{file.path} #{css_path}")

    true
  end

end


# module Jekyll

#   # Expects a lessc: key in your _config.yml file with the path to a local less.js/bin/lessc
#   # Less.js will require node.js to be installed
#   class LessJsGenerator < Generator
#     safe true
#     priority :low

#     def generate(site)
#       # location of less compiler
#       lessc = site.config['lessc'] || "lessc"
#       raise "Missing 'lessc' path in site configuration" if(!lessc)

#       # css destination
#       css_dest = site.config['css_dest'] || "/"

#       less_files = Array.new

#       # static_files have already been filtered against excludes, etc.
#       site.static_files.delete_if do |sf|
#         next if not File.extname(sf.path) == ".less"

#         less_dir = File.dirname(sf.path.gsub(site.source, ""))
#         less_name = File.basename(sf.path)

#         # add out less file
#         less_files.push(LessCssFile.new(site, site.source, less_dir, less_name, css_dest, lessc))

#         # return true so less file gets removed
#         # and not copied to _site output
#         true
#       end

#       less_files.each do |file|
#         puts file.path if File.extname(file.path) == ".css"
#       end

#       # concat new less pages with site static files
#       site.static_files.concat(less_files)
#     end

#   end


#   class LessCssFile < StaticFile

#     attr_accessor :lesspath, :cssdir, :lessc, :name

#     def initialize(site, base, dir, name, cssroot, lessc)
#       super(site, base, dir, name, nil)

#       self.lesspath = File.join(base, dirless_dir, name)
#       self.cssdir = cssroot
#       self.lessc = lessc
#     end

#     def write(dest)
#       # css name
#       less_ext = /\.less$/i
#       css_name = self.name.gsub(less_ext, ".css")

#       # css full path
#       css_path = File.join(dest, self.cssdir)
#       css = File.join(css_path, css_name)

#       # make sure dir exists
#       FileUtils.mkdir_p(css_path)

#       # puts "#{self.lessc} #{self.lesspath} #{css}"
#       # execute shell command
#       system("#{self.lessc} #{self.lesspath} #{css}")
#     end
#   end

# end