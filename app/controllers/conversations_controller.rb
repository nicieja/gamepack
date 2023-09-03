# frozen_string_literal: true

class ConversationsController < ApplicationController
  before_action :set_conversation, only: %i[show]
  respond_to :html

  def show
    @messages = @conversation.messages.visible.asc
    respond_with @conversation
  end

  def create
    @conversation = Conversation.create!

    seed @conversation, with: system_message
    respond_with @conversation
  end

  private

  def set_conversation
    @conversation = Conversation.find params.require(:id)
  end

  def seed(conversation, with:)
    return if with.blank?

    conversation.messages.create!(role: :system, content: with)
  end

  def system_message
    Character.first
             .try(:then) { |character| Prompt.character(character) }
  end
end
