
require 'json'


module makefeatured
  class Generator < Jekyll::Generator
    safe true
    priority :highest

    def generate(site)
      td=Time.now.to_i %(3600*24)
      puts "have time"
      puts td
      #site.data['featured']=td
      puts "set site var"
      #puts site.data['featured']
    end
  end
end