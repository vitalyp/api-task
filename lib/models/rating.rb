# frozen_string_literal: true

class Rating < ActiveRecord::Base
  belongs_to :post, dependent: :destroy
  belongs_to :user, inverse_of: :ratings
  validates :points, :inclusion => 1..5

  validates :post, presence: true
  validates :user, presence: true
end
