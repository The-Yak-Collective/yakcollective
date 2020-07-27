require 'addressable/uri'
require 'json'
require 'open-uri'

module Jekyll
  class RoamPageGenerator < Generator
    safe true

    def generate(site)
      begin
      p "we read directly from administartive branch for now. someday will debug the open file mechanism and even the read from site data mechanism"

      site.data['roam']=JSON.load(open('https://raw.githubusercontent.com/The-Yak-Collective/yakcollective/admin-improvements/_data/demo.json')) #demo is shorter than artofgig
      p 1
      p site.data['roam']
      p 2
      puts site.data['roam']
         p 3   
      f=File.read('_data/demo.json')
      puts JSON.pretty_generate(JSON.load(f))
      p 3.1

     puts site.data['roam'].length()
      p 4
      f=File.read('_data/artofgig.json')
      puts JSON.pretty_generate(JSON.load(f))

      p site.data.artofgig[0]
      p 5
       puts site.data['roam'].demo
     p 6
      f=File.read('_data/artofgig.json')
      puts JSON.pretty_generate(JSON.load(f))


=begin      
      if site.layouts.key? 'roam_format'
        dir =  'Roam'
        site.data.ArtOfGig.each_key do |page| #page was catagory
        dir='roam_pages'
        #get url, if possible
          site.pages << RoamPage.new(site, site.source, File.join(dir, page), page)
        end
       
      end
=end 
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
      @name = 'index.html'

      begin self.process(@name)
          self.read_yaml(File.join(base, '_layouts'), 'roam_format.html')
          self.data['roam_title'] = Addressable::URI.encode_component(page.title)
          self.data['content']=page.string
          self.data['title'] = page.title
      rescue
          puts "failed for page builder"
      end
    end
  end
end