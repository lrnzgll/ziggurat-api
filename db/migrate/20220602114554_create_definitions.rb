# frozen_string_literal: true

class CreateDefinitions < ActiveRecord::Migration[7.0]
  def change
    create_table :definitions do |t|
      t.text :body
      t.references :expression, null: false, foreign_key: true

      t.timestamps
    end
  end
end
