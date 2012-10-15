class CreateCmtvotes < ActiveRecord::Migration
  def change
    create_table :cmtvotes do |t|
      t.references :user
      t.references :post
      t.references :comment
      t.time :time

      t.timestamps
    end
    add_index :cmtvotes, :user_id
    add_index :cmtvotes, :post_id
    add_index :cmtvotes, :comment_id
  end
end
