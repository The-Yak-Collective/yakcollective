#!/usr/bin/env ruby

require 'yaml'

members = YAML.load(File.read("_data/members.yml"))

puts "title = The Yak Collective"
puts ""

members.each do |member_uid, member|
	if member.has_key? "feed"
		puts "[" + member_uid + "]"
		puts "title = " + member_uid
		puts "feed = " + member["feed"]
		puts ""
	end
end
