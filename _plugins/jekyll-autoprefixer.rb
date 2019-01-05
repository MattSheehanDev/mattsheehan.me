# Converts less files to css
#
# Uses the following properties in _config.yaml
# => lessc: path of less compiler, can be ommitted if less if included in the sys env path
# => css_dest: directory where all css output will write to
#
# Notes
# => css files will have the same root name as their less counterparts

require 'autoprefixer-rails'

Jekyll::Hooks.register :site, :post_write do |site|

    files = [
        '_site/assets/css/main.css',
        '_site/assets/css/fonts.css'
    ]

    files.each do |file|
        css = File.read(file);
        result = AutoprefixerRails.process(css,
            from: file,
            to: file,
            browsers: ['cover 99.5%']
            # map:  { prev: File.read(map), inline: false }
        )
        File.open(file, 'w') { |io| io << result.css }
    end

end

