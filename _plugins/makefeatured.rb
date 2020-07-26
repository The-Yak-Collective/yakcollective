#thank you https://github.com/18F/jekyll-get
require 'json'
#require 'hash-joiner'
require 'open-uri'

module Jekyll_Get
  class Generator < Jekyll::Generator
    safe true
    priority :highest

    def generate(site)
      td=Time.now.to_i %(3600*24)
      site.data['featured']=td
    end
  end
end