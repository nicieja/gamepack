# frozen_string_literal: true

class ConversationsController < ApplicationController
  before_action :set_conversation, only: %i[show]
  respond_to :html

  def show
    @messages = @conversation.messages.asc
    respond_with @conversation
  end

  def create
    @conversation = Conversation.create!
    respond_with @conversation
  end

  private

  def set_conversation
    @conversation = Conversation.find params.require(:id)
  end
end
