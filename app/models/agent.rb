# frozen_string_literal: true

# This model is a service object that generates a response from the
# character in a conversation using OpenAI's API. It is a Sidekiq job
# that is enqueued when a user sends a message to a conversation.
# It streams the response to the conversation as it is being generated.
class Agent
  include Sidekiq::Job

  class << self
    alias respond_async perform_async
  end

  # This method is the entry point for the Sidekiq job. It finds the conversation
  # by its ID and then generates a response from the character using the GPT model.
  def perform(conversation_id)
    conversation = Conversation.find(conversation_id)
    gpt(conversation)
  end

  alias respond perform

  private

  # This method creates a new message with the role of assistant and empty content.
  # It then uses the OpenAI client to generate a response for this message.
  def gpt(conversation)
    message = conversation.messages.create(role: :assistant, content: '')

    client.chat(
      parameters: {
        temperature: 0.1,
        model: 'gpt-3.5-turbo',
        stream: stream_proc(message),
        messages: messages(conversation)
      }
    )
  end

  def messages(conversation)
    conversation.messages.asc.map do |message|
      {
        role: message.role,
        content: message.content
      }
    end
  end

  # This method returns a proc that is used to stream the response from the GPT model.
  # The proc takes a chunk of the response and the bytesize (which is not used here).
  # It then updates the content of the message with the new content from the chunk.
  def stream_proc(message)
    proc do |chunk, _bytesize|
      new_content = chunk.dig('choices', 0, 'delta', 'content')
      message.update(content: message.content + new_content) if new_content
    end
  end

  def client
    @client ||= OpenAI::Client.new(
      access_token: ENV.fetch('OPENAI_API_KEY', nil)
    )
  end
end
