class RenameTextInPitches < ActiveRecord::Migration
  def change
    rename_column :pitches, :text, :description
  end
end
