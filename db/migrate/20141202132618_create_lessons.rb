class CreateLessons < ActiveRecord::Migration
  def change
    create_table :lessons do |t|
      t.string :title
      t.string :instructor
      t.string :schedule_repeat
      t.text :warm_up
      t.text :conditioning
      t.text :events

      t.timestamps
    end
  end
end
