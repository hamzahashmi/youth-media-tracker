class AddCategoryIdToPitches < ActiveRecord::Migration
  def change
  	add_column :pitches, :category_id, :integer
  	remove_column :pitches, :category
  end
end
