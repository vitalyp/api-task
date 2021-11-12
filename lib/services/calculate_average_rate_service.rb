# frozen_string_literal: true

class CalculateAverageRateService
  attr_reader :post_id

  def initialize(post_id)
    @post_id = post_id
  end

  def perform
    check_post_exists!

    post.ratings.sum(:points).to_f / post.ratings.count
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
end
