# frozen_string_literal: true

class Rating < ActiveRecord::Base
  belongs_to :post, dependent: :destroy
  belongs_to :user, inverse_of: :ratings
end