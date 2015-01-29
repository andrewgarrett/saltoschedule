class CreateEquipment < ActiveRecord::Migration
  def change
    create_table :equipment do |t|
      t.string :name
      t.belongs_to :user
      t.integer :max_class
      t.text :desc

      t.timestamps
    end
  end
end
