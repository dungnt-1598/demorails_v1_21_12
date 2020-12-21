class CreateCommentsAndTags < ActiveRecord::Migration[6.0]
  def change
    create_table :comments_tags, id: false do |t|
      t.belongs_to :comment
      t.belongs_to :tag
    end
  end
end
