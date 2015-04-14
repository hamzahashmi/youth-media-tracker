class CreateComments < ActiveRecord::Migration
  def change
    create_table :comments do |t|
      t.integer :pitch_id
      t.text :body
      t.references :user, index: true

      t.timestamps null: false
    end
    add_index :comments, :pitch_id
    add_foreign_key :comments, :users
  end
end
