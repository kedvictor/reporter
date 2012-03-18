class CreateRecords < ActiveRecord::Migration
  def change
    create_table :records do |t|
      t.integer :user_id
      t.integer :project_id
      t.integer :activity_id
      t.date :date
      t.time :time
      t.text :description

      t.timestamps
    end
  end
end
