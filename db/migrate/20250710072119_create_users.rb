class CreateUsers < ActiveRecord::Migration[8.0]
  def change
    create_table :users do |t|
      t.string :email, null: false
      t.string :password_digest, null: false
      t.string :role, null: false, default: 'user'
      t.string :first_name, null: false
      t.string :last_name, null: false
      t.datetime :confirmed_at

      t.timestamps
    end

    add_index :users, :email, unique: true
    add_index :users, :role
    add_index :users, :confirmed_at
  end
end
