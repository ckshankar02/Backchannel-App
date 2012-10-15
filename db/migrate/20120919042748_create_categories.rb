class CreateCategories < ActiveRecord::Migration
  def change
    create_table :categories do |t|
      t.string :categoryname
      t.integer :postcount

      t.timestamps
    end
  end
end
