class CreateUsers < ActiveRecord::Migration[7.0]
  def up
    create_table :users, id: false do |t|
      t.binary :id, limit: 36, primary: true, null: false
      t.string :username, null: false
      t.string :password_digest, null: false
      t.string :first_name, null: false
      t.string :last_name, null: false
      t.string :email, null: false
      t.timestamps null: false
    end

    add_index :users, :username, unique: true
  end

  def down
    drop_table :users
  end
end
