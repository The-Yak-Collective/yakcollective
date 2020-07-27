require 'addressable/uri'
require 'json'
require 'open-uri'

module Jekyll
  class RoamPageGenerator < Generator
    safe true

    def generate(site)
      begin
      p "started reading roam files"
    f=File.read('_data/artofgig.json')# of course, by putting it in data, it means the files are read twice and now they are also avaiable under site.data.artofgig
      site.data['roam']=JSON.load(f) 

      if site.layouts.key? 'roam_format'

        dir =  'roam'

        site.data['roam'].each_with_index do |pag,idx| #page was catagory in original code
          print "at roam page:", idx
          break if idx == 10
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

      begin
        @name = ttl2link(pag['title']) << '.md'
      rescue
        puts "trouble with encoding name", pag['title']
      end

      begin 
          self.process(@name)
          self.read_yaml(File.join(base, '_layouts'), 'roam_format.html')
          self.data['cont']= render(pag,0) 
          
          self.data['title'] = pag['title'] 
      rescue
          puts "failed for page builder :("
          p  pag['title'], @name
          puts "managed to print title..."
      end
    end
#json records have title, always. some have "children". can have both string and children.  each children has a string, i think. children can have children. have []() links and [[]]links
      def ttl2link(s)
        t=s.dup
        t.gsub!(' ','_')
        return t.gsub!(/[^0-9A-Za-z.\-]/, '_') || t #Addressable::URI.encode_component(t) # does not remove ":" # need better FS safe encoding here
      end

      def render(obj,n)
        obj.each_key do |k|
            if k == 'string'
                s=obj[k]
                s=linkify(s,0)
                return  '&nbsp;&nbsp;&nbsp;&nbsp;'*n <<  '* ' << s << "\n\n"
            else
                if k == 'children'
                    s=''
                    obj[k].each do |c|
                        s=s << render(c,n+1)
                    end
                    return s 
                end
            end
        end
        return ''
      end
      def linkify(s,i0)
        puts dir #fudge=dir[0..dir.index('/roam/')] << #cannot figure out how dir got the page name added to it. was it markup?
        sp=s.index('[[',i0)
        ep=s.index(']]',i0)
        if sp && ep && (sp<ep)
            
            s1=s[0..sp+1]
            s2=s[sp+2..ep-1]
            s3=s[ep..-1]
            lnk=' [' << s2 << '](' << dir <<  ttl2link(s2) << ')' << ' [' << s2 << '](' << '../' <<  ttl2link(s2) << ')'
            return linkify(s1 << lnk <<s3,ep+2)
        else
            return s
        end
      end
  end
end