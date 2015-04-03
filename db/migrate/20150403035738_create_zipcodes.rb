class CreateZipcodes < ActiveRecord::Migration
  def change
    create_table :zipcodes do |t|
      t.integer :code
      t.string :county

      t.timestamps null: false
    end
  end
end
