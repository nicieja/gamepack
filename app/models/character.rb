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
  # `requirements` attribute refers to the character's
  # required behavior
  attribute :requirements, :string
  # `banned_actions` attribute refers to any behavior the character
  # is prohibited from doing
  attribute :banned_actions, :string
  # Add samples of the character's dialogue so that the model can learn
  # how the character speaks and generate dialogue based on that
  attribute :samples, :string, array: true, default: -> { [] }

  validates :name, presence: true
  validates :age, presence: true, numericality: { only_integer: true }
  validates :languages, presence: true
  validates :backstory, presence: true
  validates :location, presence: true

  def to_prompt
    as_json(except: %i[id created_at updated_at samples])
      .symbolize_keys
      .merge(samples: samples.map { |sample| "- #{sample}" }.join("\n"))
  end
end
