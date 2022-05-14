class CreateExpressions < ActiveRecord::Migration[7.0]
  def change
    create_table :expressions do |t|
      t.text :body
      t.text :definition
      t.text :context
      t.text :context_source

      t.timestamps
    end
  end
end
