class AddNameToUsers < ActiveRecord::Migration
  def change
    add_column :users, :date_of_birth, :datetime
    add_column :users, :gender, :integer, default: 0
    add_column :users, :address_street, :string
    add_column :users, :address_city, :string
    add_column :users, :address_state, :string
    add_column :users, :address_zip_code, :integer 
    add_column :users, :bio, :string
    add_column :users, :phone_number, :integer
  end
end
