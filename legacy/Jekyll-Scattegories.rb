# Jekyll plugin for organizing post categories of the same type


module Jekyll

	class Scattegory < Generator
		priority :low
		safe true

		def generate(site)
			site.categories.each_pair do |category, pages|
				unless pages.kind_of?(Array)
					next
				end

				if(pages.length > 1)
					pages = pages.sort {|x,y| x <=> y}
					prev = nil
					pages.each do |page|
						page.data["next_in_category"] = page.next
						page.data["prev_in_category"] = prev
						prev = page
					end
				end
			end
		end

	end

end