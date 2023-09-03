# frozen_string_literal: true

class AddAppearanceToCharacters < ActiveRecord::Migration[7.0]
  def change
    add_column :characters, :appearance, :string

    change_column_null :characters, :age, true
    change_column_null :characters, :languages, true
    change_column_null :characters, :backstory, true
    change_column_null :characters, :location, true
  end
end
