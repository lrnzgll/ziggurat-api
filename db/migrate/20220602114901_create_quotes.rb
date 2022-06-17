class CreateQuotes < ActiveRecord::Migration[7.0]
  def change
    create_table :quotes do |t|
      t.text :body
      t.text :source
      t.references :expression, null: false, foreign_key: true

      t.timestamps
    end
  end
end
