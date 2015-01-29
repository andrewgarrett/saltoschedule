class AddClassStartendtime < ActiveRecord::Migration
  def change
    add_column :lessons, :start_time, :text
    add_column :lessons, :end_time, :text
  end
end
