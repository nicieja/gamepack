# frozen_string_literal: true

# The `Prompt` class is responsible for generating prompts for characters. It uses
# the I18n library to fetch the prompts from the prompt library. We encapsulate
# this logic in a class so that we can easily change how prompts are stored
# in the future. For example, they could be stored in a database or in a third-party
# service.
class Prompt
  class << self
    # The `character` method is used to set the behavior of the AI assistant.
    # It fetches a prompt that instructs the assistant to impersonate a specific
    # character. The character's attributes are passed as arguments, and the method
    # returns a string that is used as a prompt for the assistant. This way,
    # the assistant can behave like the character it needs to impersonate.
    def character(character, language: :en)
      I18n.t('prompts.character', language:, **character.to_prompt)
    end
  end
end
