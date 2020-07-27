require 'addressable/uri'
require 'json'
require 'open-uri'

module Jekyll
  class RoamPageGenerator < Generator
    safe true

    def generate(site)
      begin
      p "started"
f=File.read('_data/artofgig.json')
      site.data['roam']=JSON.load(f) 

      if site.layouts.key? 'roam_format'
        dir =  'roam'
        site.data['roam'].each_key do |page| #page was catagory in original code
          site.pages << RoamPage.new(site, site.source, dir, page)
        end
       
      end

      rescue
      puts "failed in main"
      end
    end
  end

  # A Page subclass. page has contenst and roam_url. and title
  class RoamPage < Page
    def initialize(site, base, dir, page)
      @site = site
      @base = base
      @dir  = dir
      @name = Addressable::URI.encode_component(page.title)

      begin 
          self.process(@name)
          self.read_yaml(File.join(base, '_layouts'), 'roam_format.html')
          self.data['content']="no content for now" #page.string
          self.data['title'] = page.title
      rescue
          puts "failed for page builder", page.title
      end
    end
  end
end