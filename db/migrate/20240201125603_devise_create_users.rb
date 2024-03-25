# frozen_string_literal: true

# Migration for generate Users table with devise
class DeviseCreateUsers < ActiveRecord::Migration[7.1]
  def up
    create_enum :role, %i[employee manager admin superadmin]

    create_table :users, id: :uuid do |t|
      t.string :email,              null: false, default: ''
      t.string :encrypted_password, null: false, default: ''
      t.references :company, null: false, foreign_key: true, type: :uuid
      t.enum :role, enum_type: 'role', default: 'employee', null: false
      t.string   :reset_password_token
      t.datetime :reset_password_sent_at
      t.datetime :remember_created_at
      t.integer  :sign_in_count, default: 0, null: false
      t.datetime :current_sign_in_at
      t.datetime :last_sign_in_at
      t.string   :current_sign_in_ip
      t.string   :last_sign_in_ip
      t.string   :confirmation_token
      t.datetime :confirmed_at
      t.datetime :confirmation_sent_at
      t.string   :unconfirmed_email
      t.integer  :failed_attempts, default: 0, null: false
      t.string   :unlock_token
      t.datetime :locked_at
      t.timestamps null: false
    end

    add_index :users, :email,                unique: true
    add_index :users, :reset_password_token, unique: true
    add_index :users, :confirmation_token,   unique: true
    add_index :users, :unlock_token,         unique: true
  end

  def down
    remove_index :users, :email
    remove_index :users, :reset_password_token
    remove_index :users, :confirmation_token
    remove_index :users, :unlock_token

    remove_foreign_key :users, column: :company_id
    remove_column :users, :company_id

    drop_enum :role

    drop_table :users
  end
end
