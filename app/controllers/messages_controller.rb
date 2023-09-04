# frozen_string_literal: true

# This controller is responsible for managing messages in a conversation.
# When a new message is created, it is saved with the role of 'user' and
# the content provided by the user. After the message is created, the Agent
# model is used to generate a response. This is done asynchronously using
# the respond_async method of the Agent model. Finally, a turbo_stream format
# response is sent. This allows the page to be updated without a full page
# refresh.
class MessagesController < ApplicationController
  def create
    @message = Message.create!(attributes)

    Agent.respond_async(@message.conversation_id)

    respond_to do |format|
      format.turbo_stream
    end
  end

  private

  def attributes
    params.require(:message)
          .permit(:content)
          .merge(
            conversation_id: params.require(:conversation_id),
            role: :user
          )
  end
end
