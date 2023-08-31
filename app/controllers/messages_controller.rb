# frozen_string_literal: true

class MessagesController < ApplicationController
  def create
    @message = Message.create!(attributes)

    Response.perform_async(@message.conversation_id)

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
