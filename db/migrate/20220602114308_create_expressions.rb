# frozen_string_literal: true

class CreateExpressions < ActiveRecord::Migration[7.0]
  def change
    create_table :expressions do |t|
      t.string :body

      t.timestamps
    end
  end
end
