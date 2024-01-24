# frozen_string_literal: true

# Migration for create the companies table
class CreateCompanies < ActiveRecord::Migration[7.1]
  def up
    create_table :companies, id: :uuid do |t|
      t.string :cif, null: false

      t.timestamps
    end

    add_index :companies, :cif, unique: true
  end

  def down
    drop_table :companies
  end
end
