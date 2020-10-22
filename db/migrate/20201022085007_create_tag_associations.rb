class CreateTagAssociations < ActiveRecord::Migration[6.0]
  def change
    create_table :tag_associations do |t|
      t.references :task
      t.references :tag
    end
  end
end
