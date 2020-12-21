class CreateLikes < ActiveRecord::Migration[6.0]
  def change
    create_table :likes do |t|
      t.belongs_to :user, null: false, foreign_key: true
      t.references :tagetable, polymorphic: true
      t.timestamps
    end
  end
end