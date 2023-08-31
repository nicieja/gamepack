# frozen_string_literal: true

class CreateMessages < ActiveRecord::Migration[7.0]
  def change
    create_table :messages, id: :string do |t|
      t.references :conversation, null: false, foreign_key: true, type: :string
      t.integer :role, null: false
      t.string :content, null: false

      t.timestamps
    end
  end
end
