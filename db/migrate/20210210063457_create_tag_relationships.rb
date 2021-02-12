class CreateTagRelationships < ActiveRecord::Migration[5.2]
  def change
    create_table :tag_relationships do |t|
      t.references :project, foreign_key: true
      t.references :tag, foreign_key: true

      t.timestamps
    end
     add_index :tag_relationships, [:project_id,:tag_id],unique: true
  end
end
