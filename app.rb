# frozen_string_literal: true

require_all 'lib'

VERSION = '1.0.1'

class App < Sinatra::Base
  get '/' do
    {
      application: 'API TASK',
      version: VERSION,
      total_users_count: User.count,
      total_posts_count: Post.count
    }.to_json
  end

  error ApiErrors::NoPostError do
    halt(
      422, {'Content-Type' => 'application/json'},
      { message: "Sorry, could not find requested post" }.to_json
    )
  end

  # Get Posts
  # curl -i -X GET -H "Content-Type: application/json" http://127.0.0.1:9393/posts
  get '/posts' do
    content_type :json
    status 200
    Post.all.to_json(only: [ :id, :title, :content ])
  end

  # Create Post
  # curl -i -X POST -H "Content-Type: application/json" -d'{"login":"user","title":"Title","content":"Content","ip":"127.0.0.1"}' http://127.0.0.1:9393/posts
  # params: login, title, content, ip
  post '/posts' do
    result = nil
    t = Benchmark.ms {
      result = PostCreateService.new(JSON.parse(request.body.read)).perform
    }
    puts "Processed request in (ms): #{t}"

    content_type :json

    if result.errors.any?
      status 400
      result.errors.to_json
    else
      status 200
      result.post.to_json
    end
  end

  # Rate Post
  post '/post/:post_id/rate/:point' do
    result = RatePostService.new(post_id: params['post_id'], rate_point: params['rate_point']).perform
    halt(422, {'Content-Type' => 'application/json'}, { message: result.errors }.to_json) if result.errors.any?

    average_rate = CalculateAverageRateService.new(params['post_id']).perform
    content_type :json
    status 200
    average_rate
  end

  # Get top N posts within average rating
  # 1. get average rating
  # 2. get top N posts - what is TOP posts please explain with examples please
  get '/average/:num' do
    average = Rating.average(:points)

    content_type :json
    status 200
    average
  end

  get '/multi_ip' do
    ips = Post.select(:ip).group(:ip).having("count(*) > 1")
    content_type :json
    status 200

    ips.collect do |ip|
      user_ids = Post.where(ip: ip).pluck(:user_id)
      logins = User.where(id: user_ids).pluck(:login)
      { ip: ip, logins: logins }
    end.to_json
  end
end
