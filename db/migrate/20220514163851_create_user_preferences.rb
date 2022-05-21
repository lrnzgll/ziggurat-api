class CreateUserPreferences < ActiveRecord::Migration[7.0]
  def change
    create_table :user_preferences do |t|
      t.text :periodicity, default: 'weekly'
      t.boolean :email, default: false
      t.boolean :sms, default: false
      t.boolean :whatsapp, default: false
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
