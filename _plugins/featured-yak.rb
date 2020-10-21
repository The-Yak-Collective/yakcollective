# Standard-ish Jekyll generator plugin lead-in. See:
#
#     https://jekyllrb.com/docs/plugins/generators/
#
# Note that module names must start with a capital letter, because...
# Reasons.
#
module MakeFeaturedYak
	class Generator < Jekyll::Generator
		safe true

		def generate(site)

			# What is today's date? We use a `Time` object, since
			# that's how Jekyll stores timestamps internally.
			#
			# Unfortunately, I can't find a sensible way to build a
			# `Time` object that corresponds to "the start of today",
			# hence the monstrosity in the first line below.
			#
			buildDate = Time.new(Time.now.year, Time.now.month, Time.now.day)
			site.data["build_date"] = buildDate
			puts "Featured yak build date: #{buildDate.strftime('%Y-%m-%d')}"

			# Only members whose `date` property is on or after
			# `buildDate` should be considered.
			#
			currentMembers = Array.new
			site.pages.each do |page|
				if page.url =~ /^\/members\/[^\/]+\// and !page.data["date"].nil?
					if page.data["date"].to_time <= buildDate
						currentMembers << page
					end
				end
			end
			currentMemberCount = currentMembers.length()
			puts "Currently active members: #{currentMemberCount}"

			# Grab a pseudo-random current member for our featured yak.
			# We do this by taking the current date in YYYYMMDD form
			# modulo the `currentMemberCount`, and then using that as
			# our array index. The reason to do this, rather than just
			# using Ruby's rand(), is to ensure that while the featured
			# yak is random-ish for outside observers, it is actually
			# deterministic with respect to the build date (since the
			# featured yak should be the same for every build in a
			# given day).
			#
			featuredYakIndex = buildDate.strftime("%Y%m%d").to_i % currentMemberCount
			featuredYak = currentMembers[featuredYakIndex]
			site.data["featured_yak"] = featuredYak
			puts "Today's featured yak is: #{featuredYak.data['title']}"
		end
	end
end
