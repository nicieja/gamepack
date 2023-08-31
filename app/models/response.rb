# frozen_string_literal: true

# This model is a service object that generates a response from the
# character in a conversation using OpenAI's API. It is a Sidekiq job
# that is enqueued when a user sends a message to a conversation.
# It streams the response to the conversation as it is being generated.
class Response
  include Sidekiq::Job

  def perform(conversation_id)
    conversation = Conversation.find(conversation_id)
    gpt(conversation)
  end

  private

  def gpt(conversation)
    message = conversation.messages.create(role: :character, content: '')

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
        role: roles.fetch(message.role.to_sym),
        content: message.content
      }
    end
  end

  def roles
    {
      character: :assistant,
      user: :user
    }
  end

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
