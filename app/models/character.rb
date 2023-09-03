# frozen_string_literal: true

# This is the `Character` model. It represents a character in a story.
# Characters are used to prompt the model to generate dialogue based
# on their attributes.
class Character < ApplicationRecord
  key :char

  attribute :name, :string
  attribute :age, :integer
  # Use natural language to describe the character's proficiency
  # with languages. You can specify multiple languages by separating
  # them with commas.
  attribute :languages, :string
  attribute :backstory, :string
  attribute :personality, :string
  attribute :lifestyle, :string
  # `relationships` attribute refers to the character's relationships
  # with other characters
  attribute :relationships, :string
  attribute :location, :string
  # `currently` attribute refers to the character's state
  # at the starting point of the story
  attribute :currently, :string
  attribute :goal, :string
  # `requirement` attribute refers to the character's
  # required behavior
  attribute :requirement, :string
  # `ban` attribute refers to any behavior the character
  # is prohibited from doing
  attribute :ban, :string

  validates :name, presence: true
  validates :age, presence: true, numericality: { only_integer: true }
  validates :languages, presence: true
  validates :backstory, presence: true
  validates :location, presence: true

  def to_prompt
    as_json(
      except: %i[id created_at updated_at]
    ).symbolize_keys
  end
end
