# frozen_string_literal: true

class AddQuotesToCharacters < ActiveRecord::Migration[7.0]
  def change
    change_table :characters do |t|
      t.string 'quotes', default: [], null: false, array: true
    end
  end
end
