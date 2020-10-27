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
		priority :lowest

		def generate(site)

			# What is today's date? We use a `Time` object, since
			# that's how Jekyll stores timestamps internally.
			#
			# Unfortunately, I can't find a sensible way to build a
			# `Time` object that corresponds to "the start of today",
			# hence the monstrosity in the first line below.
			#
			buildDate = Time.new(Time.now.year, Time.now.month, Time.now.day)

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

			# Grab a pseudo-random current member for our featured yak.
			# We do this by taking the current date in seconds since
			# epoch modulo the `currentMemberCount` and then using that
			# as our array index. The reason to do this, rather than
			# just using Ruby's rand() (or Jekyll's `sample`), is to
			# ensure that while the featured yak is random-ish for
			# outside observers, it is actually deterministic with
			# respect to the build date (since the featured yak should
			# be the same for every build in a given day). (Since new
			# members go live on specific dates, invariance w.r.t. date
			# is the same as invariance w.r.t. the list of members on
			# that date.)
			#
			featuredYakIndex = buildDate.strftime("%s").to_i % currentMemberCount
			featuredYak = currentMembers[featuredYakIndex]
			site.data["featured_yak"] = featuredYak
			puts "      Featured yak: #{featuredYak.data['title']}"
		end
	end
end
