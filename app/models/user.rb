# frozen_string_literal: true

class User < ActiveRecord::Base
  has_many :posts
  has_many :ratings

  validates :login, uniqueness: true, presence: true
end
