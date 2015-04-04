class ChangeTypeToMedia < ActiveRecord::Migration
  def change

  	rename_column :pitches, :type, :media
  end
end
