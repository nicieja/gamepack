class Character < ApplicationRecord
  key :char

  attribute :name, :string
  attribute :age, :integer
  attribute :backstory, :string
  attribute :personality, :string
  attribute :lifestyle, :string
  attribute :location, :string
  # +currently+ attribute refers to the character's state
  # at the starting point of the story
  attribute :currently, :string
  attribute :goal, :string
  # +requirement+ attribute refers to the character's
  # required behavior
  attribute :requirement, :string
  # +ban+ attribute refers to any behavior the character
  # is prohibited from doing
  attribute :ban, :string

  validates :name, presence: true
  validates :age, presence: true, numericality: { only_integer: true }
  validates :backstory, presence: true
  validates :location, presence: true
end
