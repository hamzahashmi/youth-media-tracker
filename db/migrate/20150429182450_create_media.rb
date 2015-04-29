class CreateMedia < ActiveRecord::Migration
  def change
    create_table :media do |t|
      t.string :context
      t.integer :user_id
      t.string :token
      t.integer :week_session_id
      t.datetime :due_date

      t.timestamps null: false
    end
  end
end
