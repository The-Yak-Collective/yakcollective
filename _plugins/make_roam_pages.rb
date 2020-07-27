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
p 1
      if site.layouts.key? 'roam_format'
      p 2
        dir =  'roam'
        p 3
        site.data['roam'].each do |pag| #page was catagory in original code
        p 4
#        p pag
        p pag['title']
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
    p 5
    p site,base,dir,pag['title']
    p 5.1
      @site = site
      @base = base
      @dir  = dir
p 5.5
n=Addressable::URI.encode_component(pag['title'])
puts "added name:",n
      @name = n
p 6
      begin 
          self.process(@name)
          self.read_yaml(File.join(base, '_layouts'), 'roam_format.html')
          self.data['content']="no content for now" #json records have title, always. some have "children". can have both string and children.  each children has a string, i think. children can have children. have []() links and [[]]links
          self.data['title'] = pag['title']
      rescue
          puts "failed for page builder"
          puts  pag['title']
          puts "managed to print title..."
      end
    end
  end
end