require 'addressable/uri'

module Jekyll
  class RoamPageGenerator < Generator
    safe true

    def generate(site)
      if site.layouts.key? 'roam_format'
        dir =  'Roam'
        site.data.ArtOfGig.each_key do |page| #page was catagory
        dir='roam_pages'
        #get url, if possible
          site.pages << RoamPage.new(site, site.source, File.join(dir, page), page)
        end
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

      self.process(@name)
      self.read_yaml(File.join(base, '_layouts'), 'roam_format.html')
      self.data['roam_title'] = Addressable::URI.encode_component(page.title)
      self.data['content']=page.string
      self.data['title'] = page.title
    end
  end
end