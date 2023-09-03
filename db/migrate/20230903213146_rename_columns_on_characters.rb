# frozen_string_literal: true

class RenameColumnsOnCharacters < ActiveRecord::Migration[7.0]
  def change
    rename_column :characters, :quotes, :samples
    rename_column :characters, :ban, :banned_actions
    rename_column :characters, :requirement, :requirements
  end
end
