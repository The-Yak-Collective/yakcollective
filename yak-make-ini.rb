#!/usr/bin/env ruby

require 'yaml'

members = YAML.load(File.read("_data/members.yml"))

puts "title = The Yak Collective"
puts ""

members.each do |member_uid, member|
	if member.has_key? "feeds"
		current_feed = 0
		member["feeds"].each do |feed|
			puts "[" + member_uid + "_" + current_feed.to_s + "]"
			puts "title = " + member_uid
			puts "feed = " + feed
			puts ""
			current_feed += 1
		end
	end
end
