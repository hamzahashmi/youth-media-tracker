class CreateSchedules < ActiveRecord::Migration
  def change
    create_table :schedules do |t|
      t.datetime :iteration_start
      t.datetime :iteration_end
      t.datetime :submission_pick

      t.timestamps null: false
    end
  end
end
