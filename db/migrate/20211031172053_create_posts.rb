# frozen_string_literal: true

class CreatePosts < ActiveRecord::Migration[5.2]
  def change
    create_table :posts do |t|
      t.belongs_to :user, foreign_key: true, index: true

      t.string :ip, null: false
      t.string :title, null: false
      t.text :content

      t.timestamps
    end
  end
end
