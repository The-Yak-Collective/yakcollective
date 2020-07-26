
require 'json'

require 'date'

module Make_featured
  class Generator < Jekyll::Generator
    safe true
    priority :highest

    def generate(site)
      td=Time.now.to_i / (3600*24)
      l=site.collections['members'].docs.length()
      puts "we have ", l, " members" 
      site.data['featured']=td % l #day number from jan 1970 modulo number of actual members. alter can be fancier calculation
      site.data['build_date']=Date.today #today's date, without hours. ensures feed is daily. though feed has other feild that ensures that
    end
  end
end
