# frozen_string_literal: true

class RatePostService
  attr_reader :post_id,
              :rate_point

  def initialize(post_id:, rate_point:)
    @post_id = post_id
    @rate_point = rate_point
  end

  def perform
    check_post_exists!

    result = OpenStruct.new(
      rating: nil,
      errors: []
    )

    Rating.with_advisory_lock(lock_name) do
      begin
        result.rating = Rating.create!(post: post, points: rate_point)
      rescue ActiveRecord::ActiveRecordError => e
        result.errors << e.message
      end
    end

    result
  end

  private

  def post
    @post ||= Post.find(post_id)
  end

  def check_post_exists!
    post
  rescue ActiveRecord::RecordNotFound
    raise ApiErrors::NoPostError
  end

  def lock_name
    "post_id_#{post_id}"
  end
end
