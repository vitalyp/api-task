# frozen_string_literal: true

class PostsController < ApplicationController
  post '/new' do
    post = PostCreateService.new(post_params).perform

    if post.valid?
      respond_with({ post: post, status: :ok })
    else
      respond_with({ error: post.errors.full_messages, status: :bad_request })
    end
  end

  private

  def post_params
    params.permit(:title, :content, :author_login, :author_ip)
  end

end
