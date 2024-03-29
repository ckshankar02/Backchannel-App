class CreatePosts < ActiveRecord::Migration
  def change
    create_table :posts do |t|
      t.string :title
      t.string :category
      t.time :time
      t.text :content
      t.references :user

      t.timestamps
    end
    add_index :posts, :user_id
  end
end
