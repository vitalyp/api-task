# frozen_string_literal: true

class PostCreateService
  attr_reader :user_params,
              :post_params

  def initialize(params)
    @user_params = params.with_indifferent_access.slice('login')
    @post_params = params.with_indifferent_access.slice('title', 'content', 'ip')
  end

  def perform
    result = OpenStruct.new(
      post: nil,
      errors: []
    )

    User.transaction do
      user = User.where(login: user_params['login']).first_or_create
      unless user.valid?
        result.errors = errors_for(user)
        raise ActiveRecord::Rollback
      end

      post = Post.create(post_params) do |p|
        p.user = user
      end
      unless post.valid?
        result.errors = errors_for(post)
        raise ActiveRecord::Rollback
      end

      result.post = post
    end

    result
  end

  private

  def errors_for(model)
    model.errors.full_messages.each { |msg| msg.prepend("#{model.class.name} creating error: ") }
  end
end
