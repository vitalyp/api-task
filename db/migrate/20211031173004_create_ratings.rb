# frozen_string_literal: true

class CreateRatings < ActiveRecord::Migration[5.2]
  def change
    create_table :ratings do |t|
      t.belongs_to :user, foreign_key: true, index: true
      t.belongs_to :post, foreign_key: true, index: true

      t.integer :points, nil: false

      t.timestamps
    end
  end
end
