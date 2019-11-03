# frozen_string_literal: true

# CreateArticles
class CreateArticles < ActiveRecord::Migration[6.0]
  def change
    create_table :articles do |t|
      t.string :title
    end
  end
end
