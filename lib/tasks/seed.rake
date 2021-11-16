# frozen_string_literal: true

# rake seed:load\["http://127.0.0.1:9393"\]

require_all './lib/tasks/commands'

namespace :seed do
  desc 'Populate database'
  task :load, [:server_addr] do |t, args|
    api_client = ApiTask::HttpClient.new(args[:server_addr])
    api_client.check_connection!

    uri = URI(args[:server_addr])
    api_client.start do |client|  # Using persisted connection..
      3.times do |t|
        data = {
          login:   "user_#{t}",
          title:   "title_#{t}",
          content: "content_#{t}",
          ip:      "0.0.0.#{t}"
        }
        puts "Perform request in (ms): " + Benchmark.ms {
          client.http_post('/posts', data)
        }.to_s

        # Performance Resume:
        #
        # Perform request in (ms): 1978.8289999996778
        # Perform request in (ms): 2010.0089999905322
        # Perform request in (ms): 1946.1779999983264
        #
        # > Persistent connection didn't do the trick.
        # > Sinatra API endpoints processes request quick enough, so issue still undiscovered:
        #
        # 127.0.0.1 - - [16/Nov/2021:16:39:48 +0200] "HEAD / HTTP/1.1" 200 90 0.0186
        # Processed request in (ms): 35.51099999458529
        # 127.0.0.1 - - [16/Nov/2021:16:39:50 +0200] "POST /posts HTTP/1.1" 200 156 0.0623
        # Processed request in (ms): 34.74099999584723
        # 127.0.0.1 - - [16/Nov/2021:16:39:52 +0200] "POST /posts HTTP/1.1" 200 156 0.0632
      end
    end
  end
end
