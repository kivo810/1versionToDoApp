class AddCategoryToTasks < ActiveRecord::Migration[6.0]
  def change
    add_reference :tasks, :category
  end
end
