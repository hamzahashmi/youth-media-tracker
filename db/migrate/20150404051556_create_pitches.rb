class CreatePitches < ActiveRecord::Migration
  def change
    create_table :pitches do |t|
      t.string :name
      t.string :media
      t.string :category
      t.string :text

      t.timestamps null: false
    end
  end
end
