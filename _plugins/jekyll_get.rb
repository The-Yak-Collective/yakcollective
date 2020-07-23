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
          p site.data['issues'][0].number
          if d['data'] == "issues"
            numissues=site.data['issues'][0].number.to_i
            p "it was issues"
            p numissues
            for i in 1..numissues
                p i
                site.data['issues'][i].reactions=JSON.load(open('https://api.github.com/repos/cranec-project/Covid-19/issues/'+i.to_s+'/reactions',
"Accept" =>"application/vnd.github.squirrel-girl-preview+json"))
                p "reactions="
                p site.data['issues'][i].reactions
            end
          end
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