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
      config.each do |d|
        begin
          target = site.data[d['data']]
          source = JSON.load(open(d['json']))
#          if target #give up option of overloading as we have trouble getting the hash-joiner in
#            HashJoiner.deep_merge target, source
#          else
            site.data[d['data']] = source
            
#          end
          p d['data']
          puts d['data']
          puts "random string"
          puts JSON.pretty_generate(site.data['issues'][0])
          puts "another random string"
          p site.data['issues'][0]['number']
          #if d['data'] == "issues" #it always is, no?
            numissues=site.data['issues'][0]['number'].to_i
            p "it was issues"
            p numissues
            for i in 55..numissues #fundge as going 1-63 gets stuck on 30 due to rate limit
                p i
                p i.to_s
                tmp=JSON.load(open('https://api.github.com/repos/cranec-project/Covid-19/issues/'+i.to_s+'/reactions',
"Accept" =>"application/vnd.github.squirrel-girl-preview+json"))
                p "read it"
                puts JSON.pretty_generate(tmp)
                p tmp
                p i
                p site.data['issues'][i]
                puts "and without i?"
                p "works so no need to show it" #JSON.pretty_generate(site.data['issues'])
                puts "let try number again"
                p site.data['issues'][0]['number']
                puts "can we see 63"
                p site.data['issues'][63]
                puts "can we see '63'"
                #puts site.data['issues']['63'] #does not work 
                p "can we see a number"
                # puts site.data['issues'][i]['number'] #crashes
                puts "now the big one"
                site.data['issues'][i]['reactions'] = "not the tmp" #tmp #also crashes. probbaly due to teh i index
                puts "survived"
                p "reactions="
                #p site.data['issues'][i]['reactions']
            end
          #end
          if d['cache']
            data_source = (site.config['data_source'] || '_data')
            path = "#{data_source}/#{d['data']}.json"
            open(path, 'wb') do |file|
              file << JSON.generate(site.data[d['data']])
            end
          end
        rescue
          next
        end
      end
    end
  end
end