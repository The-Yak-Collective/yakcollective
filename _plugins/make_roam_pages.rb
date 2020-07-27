require 'addressable/uri'
require 'json'
require 'open-uri'

module Jekyll
  class RoamPageGenerator < Generator
    safe true

    def generate(site)
      begin
      p "started reading roam files"
    f=File.read('_data/artofgig.json')
      site.data['roam']=JSON.load(f) 

      if site.layouts.key? 'roam_format'

        dir =  'roam'

        site.data['roam'].each_with_index do |pag,idx| #page was catagory in original code
          puts "at roam page:", idx
          break if idx == 50
          site.pages << RoamPage.new(site, site.source, dir, pag)
        end
       
      end

      rescue
      puts "failed in main"
      end
    end
  end

  # A Page subclass. page has contenst and roam_url. and title
  class RoamPage < Page
    def initialize(site, base, dir, pag)

      @site = site
      @base = base
      @dir  = dir

      t=pag['title'] << ' '
      t.gsub! ' ','_'
      n=Addressable::URI.encode_component(t)

      @name = n << '.html'

      begin 
          self.process(@name)
          self.read_yaml(File.join(base, '_layouts'), 'roam_format.html')
          self.data['cont']="no content for now" #json records have title, always. some have "children". can have both string and children.  each children has a string, i think. children can have children. have []() links and [[]]links
          self.data['title'] = pag['title'] << " no?"
      rescue
          puts "failed for page builder :("
          puts  "pag['title']"
          puts "managed to print title..."
      end
    end
  end
end