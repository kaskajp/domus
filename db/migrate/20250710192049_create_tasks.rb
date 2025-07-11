class CreateTasks < ActiveRecord::Migration[8.0]
  def change
    create_table :tasks do |t|
      t.string :title, null: false
      t.text :description
      t.references :assignee, null: true, foreign_key: { to_table: :users }
      t.date :due_date
      t.time :due_time
      t.string :priority, default: "medium"
      t.text :tags
      t.boolean :recurring, default: false
      t.string :recurrence_type
      t.integer :recurrence_interval
      t.datetime :completed_at
      t.references :created_by, null: false, foreign_key: { to_table: :users }

      t.timestamps
    end
    
    add_index :tasks, :due_date
    add_index :tasks, :priority
    add_index :tasks, :completed_at
  end
end
