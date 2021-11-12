# frozen_string_literal: true

require 'faker'

require 'uri'
require 'net/http'

# rake seed:load\["http://127.0.0.1:9393"\]


namespace :seed do
  desc 'Fill db with data'
  task :load, [:server_addr] do |t, args|
    puts 'works'
    server_addr = args[:server_addr]

    uri = URI("#{server_addr}/posts")

    10.times do |t|
      post_attributes = {
        uri: uri,
        login: "user_#{t}",
        title: "title_#{t}",
        content: "content_#{t}",
        ip: "0.0.0.0"
      }
      p "."
      if (t%1000 == 0)
        puts t
        puts " "
      end

      create_post(post_attributes)
    end
  end


  def create_post(uri:, login:, title:, content:, ip:)
    Net::HTTP.post(
      uri,
      { "login" => login, "title" => title, content: content, ip: ip }.to_json,
      "Content-Type" => "application/json")
  end
end
