# frozen_string_literal: true

class CreateCharacters < ActiveRecord::Migration[7.0]
  def change
    create_table :characters, id: :string do |t|
      t.string :name, null: false
      t.integer :age, null: false
      t.string :location, null: false
      t.string :languages, null: false
      t.string :backstory, null: false
      t.string :personality
      t.string :lifestyle
      t.string :relationships
      t.string :currently
      t.string :goal
      t.string :requirement
      t.string :ban
      t.timestamps
    end
  end
end
