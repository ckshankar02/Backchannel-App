class CreateUseradmins < ActiveRecord::Migration
  def change
    create_table :useradmins do |t|
      t.references :user
      t.string :username
      t.string :adminaccess

      t.timestamps
    end
    add_index :useradmins, :user_id
  end
end
