# frozen_string_literal: true

require_all 'lib'

VERSION = '1.0.2'

# Users, Posts and Ratings API
# GET  =>  /posts
# POST =>  /posts  +[:login, :title, :content]
# POST =>  /post/:post_id/rate/:point


class App < Sinatra::Base
  get '/' do
    {
      application: 'SINATRA BACKEND API',
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
end
