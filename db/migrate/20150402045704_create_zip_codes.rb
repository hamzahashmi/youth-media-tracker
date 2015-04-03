class CreateZipCodes < ActiveRecord::Migration
  def change
    create_table :zip_codes do |t|
      t.integer :zip_code
      t.string :county

      t.timestamps null: false
    end
  end
end
