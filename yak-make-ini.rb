#!/usr/bin/env ruby

require 'yaml'

members = YAML.load(File.read("_data/members.yml"))

current_member = 1

puts "title = The Yak Collective"
puts ""

members.each do |member|
	if member.has_key? "feeds"
		member["feeds"].each do |feed|
			puts "[" + current_member.to_s + "]"
			puts "title = " + member["name"]
			puts "feed = " + feed["url"]
			puts ""
			current_member += 1
		end
	end
end
