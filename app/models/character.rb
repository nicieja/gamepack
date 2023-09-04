# frozen_string_literal: true

# This is the `Character` model. It represents a character in a story.
# Characters are used to prompt the model to generate dialogue based
# on their attributes.
#
# You'll notice that this model contains a lot of attributes that
# are strings. We can get away with that because we are using a large
# language model that can generate text based on a prompt. The prompt
# can simply contain natural language that describes the character.
class Character < ApplicationRecord
  key :char

  attribute :name, :string
  attribute :age, :integer
  # Use this to describe the character's physical appearance and clothing
  attribute :appearance, :string
  # Use natural language to describe the character's proficiency
  # with languages. You can specify multiple languages by separating
  # them with commas.
  attribute :languages, :string
  # Use this to denote the character's history
  attribute :backstory, :string
  # Keep `personality` related to the character's personality traits
  attribute :personality, :string
  # The term `lifestyle` refers to the character's present way of life
  attribute :lifestyle, :string
  # Refer to the character's relationships with others, both characters
  # and non-characters
  attribute :relationships, :string
  # The character's current location. For example, they may be in a
  # specific city, country, or place like in jail.
  attribute :location, :string
  # The character's particular circumstances and state at the starting point
  # of the story. For example, they may be suspected of theft.
  # `currently` differs from `lifestyle` in that it refers to the character's
  # temporary state, whereas `lifestyle` refers to their permanent state.
  attribute :currently, :string
  # The character's goal. For example, they may want to escape from jail.
  attribute :goal, :string
  # Character's required behavior. For example, you may want to force the
  # character to be polite or to be rude.
  attribute :requirements, :string
  # Any behavior the character is prohibited from doing. For example, you
  # may want to prevent the character from telling the truth.
  attribute :banned_actions, :string
  # Add samples of the character's dialogue so that the model can learn
  # how the character speaks and generate dialogue based on that
  attribute :samples, :string, array: true, default: -> { [] }

  validates :name, presence: true
  validates :age, numericality: { only_integer: true }

  def to_prompt
    as_json(except: %i[id created_at updated_at samples])
      .symbolize_keys
      .merge(samples: samples.map { |li| I18n.t('prompts.ul', li:) }.join)
  end
end
