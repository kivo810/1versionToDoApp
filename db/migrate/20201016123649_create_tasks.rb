class CreateTasks < ActiveRecord::Migration[6.0]
  def change
    create_table :tasks do |t|
      t.string :title
      t.boolean :is_done, default: false
      t.text :note
      t.datetime :deadline_at

      t.timestamps
    end
  end
end
