# frozen_string_literal: true

# This migration adds a new column named 'jti' to the users table.
# The 'jti' column is used to store a unique JSON Web Token identifier.
# Additionally, a unique index is created on the 'jti' column to ensure its uniqueness.
# This migration is reversible, meaning it can be rolled back if necessary
# to undo the changes made to the database.
class AddJtiToUser < ActiveRecord::Migration[7.1]
  def up
    add_column :users, :jti, :string
    add_index :users, :jti, unique: true
  end

  def down
    remove_index :users, :jti
    remove_column :users, :jti
  end
end
