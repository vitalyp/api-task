# frozen_string_literal: true

class Post < ActiveRecord::Base
  belongs_to :user
  has_many :ratings

  validates :user, presence: true
  validates :title, presence: true
end
