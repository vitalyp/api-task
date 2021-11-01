# frozen_string_literal: true

class Post < ActiveRecord::Base
  belongs_to :user
  has_one :rating

  validates :title, presence: true
end
