#thank you https://github.com/18F/jekyll-get
require 'json'
#require 'hash-joiner'
require 'open-uri'

module Jekyll_Get
  class Generator < Jekyll::Generator
    safe true
    priority :highest

    def generate(site)
      config = site.config['jekyll_get']
      if !config
        return
      end
      if !config.kind_of?(Array)
        config = [config]
      end
#should be in seperate plugin, but i have something missing      
      puts "before time"
      td=Time.now.to_i / (3600*24)
      puts "have time"
      puts td % site.members.length()
      site.data['featured']=td
      puts "set site var"
      puts site.data['featured']

      
#end of other plugin
      config.each do |d|
        begin
          target = site.data[d['data']]
          source = JSON.load(open(d['json']))
#          if target #give up option of overloading as we have trouble getting the hash-joiner in. maybe it means i shoudl delete cache as well...
#            HashJoiner.deep_merge target, source
#          else
#          end
            if (d['data'] == "issues")
                numissues=source[0]['number'].to_i
                for i in 55..numissues #fundge as going 1-63 gets stuck on 30 due to rate limit
                    p i
                    tmp=JSON.load(open(d['json']+"/"+i.to_s+'/reactions',
    "Accept" =>"application/vnd.github.squirrel-girl-preview+json"))
                    source[numissues-i]['reactions']= tmp #reverse order because issues provided in reverse order by github
                end
                site.data[d['data']] = source #is a readonly after set!?
#                puts JSON.pretty_generate(site.data['issues'][0])

                      if d['cache']
                        data_source = (site.config['data_source'] || '_data')
                        path = "#{data_source}/#{d['data']}.json"
                        open(path, 'wb') do |file|
                          file << JSON.generate(site.data[d['data']])
                        end
                      end
            end
        rescue
          next
        end
      end
    end
  end
end