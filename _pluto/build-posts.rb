#!/usr/bin/env ruby

# Based on planet.rb: https://github.com/feedreader/planet.rb

# Load needed gems.
#
require "pluto/models"

# What are we building? This should be passed in on the command line.
#
if ARGV.empty?
	puts "No feed set specified..."
	exit 1
else
	$feed_set = ARGV[0]
end

# Extend "Planet" class from pluton/models. This is where all the magic
# happens.
#
class Planet

	VERSION = '1.0.0'

	# Informational banner.
	#
	def self.banner
		"build-posts.rb/#{VERSION} on Ruby #{RUBY_VERSION} (#{RUBY_RELEASE_DATE}) [#{RUBY_PLATFORM}]"
	end

	# Pluto initialization information.
	#
	def initialize
		puts self.class.banner
		puts "db settings:"

		@db_config = {
			adapter:  "sqlite3",
			database: "./#{$feed_set}.db"
		}

		pp @db_config
	end

	# Loop to generate post files
	#
	def run
		Pluto.connect( @db_config )
		Pluto::Model::Item.latest.each_with_index do |item, i|
			puts "[#{i+1}] #{item.title}"
			generate_blog_post(item)
			unless item.url.empty?
				generate_twitter_post(item)
				generate_discord_post(item)
			end
		end
	end

private

	# Generate actual blog post files.
	#
	def generate_blog_post(item)
		posts_root = "./#{$feed_set}"
		
		FileUtils.mkdir_p(posts_root)
		
		post_name = "#{posts_root}/#{item.published.strftime('%Y-%m-%d')}-#{title_to_key(item.title)}.html"

		frontmatter = {
			"title"  => item.title,
			"date"   => item.published,
			"layout" => "post-external"
		}

		unless item.url.empty?
			frontmatter["original_link"] = item.url
		end

		if $feed_set == "writings"
			frontmatter["author"] = item.feed.key.to_i
		end

		File.open(post_name, 'w:utf-8') do |post_file|
			post_file.write frontmatter.to_yaml

			# to_yaml starts YAML "document" with ---, but doesn't end it.
			#
			post_file.write "---\n\n"

			if item.content
				post_content = item.content
			elsif item.summary
				post_content = item.summary
			else
				post_content = ""
				puts "[WARNING] No content found in #{item.title}: #{item.title}"
			end

			# Replace { with &#x007b; and } with &#x007d; to work
			# around Jekyll parsing issues.
			#
			post_content = post_content.gsub(/{/, "&#x007b;")
			post_content = post_content.gsub(/}/, "&#x007d;")
		
			post_file.write post_content
		end
	end

	# Generate post files for Twitter.
	#
	def generate_twitter_post(item)
		posts_root = "./twitter"
		
		FileUtils.mkdir_p(posts_root)
	
		if $feed_set == "writings"
			post_name = "#{posts_root}/#{item.published.strftime('%s')}-#{item.feed.key}.txt"
		else
			post_name = "#{posts_root}/#{item.published.strftime('%s')}-#{$feed_set}.txt"
		end
	
		File.open(post_name, 'w:utf-8') do |post_file|
			if $feed_set == "writings"
				post_content = "Check out @#{item.feed.key}’s new post, “#{item.title}” — #{item.url}"
			elsif $feed_set == "newsletter"
				post_content = "Check out the latest edition of the Yak Talk newsletter, “#{item.title}” — #{item.url}"
			end
			
			post_file.write post_content
		end
	end

	# Generate post files for Discord.
	#
	def generate_discord_post(item)
		posts_root = "./discord"
		
		FileUtils.mkdir_p(posts_root)
	
		if $feed_set == "writings"
			post_name = "#{posts_root}/#{item.published.strftime('%s')}-#{item.feed.key}.txt"
		else
			post_name = "#{posts_root}/#{item.published.strftime('%s')}-#{$feed_set}.txt"
		end
	
		File.open(post_name, 'w:utf-8') do |post_file|
			post_content = "#{item.title} — #{item.url}"
			
			post_file.write post_content
		end
	end

	# title_to_key() helper function.
	#
	def title_to_key(title)
		key = title.downcase
		key = key.gsub(/[^a-z0-9 :-]/, "")
		key = key.gsub(/:/, " - ")
		key = key.strip
		key = key.gsub(/[ ]+/, "-")
		key = key.gsub(/-+/, "-")
  
		if key.empty?
			key = "#{Digest::MD5.hexdigest(title)}"
		end

    	return key
	end
  
end  # class Planet

# Actually run the parser.
#
Planet.new.run if __FILE__ == $0
