class AddMediaTypeToPitches < ActiveRecord::Migration
  def change
  	add_column :pitches, :media_type_id, :integer
  	remove_column :pitches, :media
  end
end