# frozen_string_literal: true

# This model represents conversations between players and characters in the game.
class Conversation < ApplicationRecord
  key :c

  has_many :messages, dependent: :destroy
end
