# frozen_string_literal: true

# This model represents dialogue between players and characters
# in the game.
class Message < ApplicationRecord
  key :mg

  enum role: { character: 0, user: 1 }
  attribute :content

  belongs_to :conversation

  validates :role, presence: true
  # Empty strings are valid, but +nil+ is not. This is because we need to save
  # the message to the database before we can stream it to OpenAI.
  validates :content, presence: true

  scope :asc, -> { order(created_at: :asc) }

  # We broadcast the message to the conversation after it is created
  # or updated. LLMs take a long time to generate text, so we don't want
  # to wait for the entire process to finish before sending the message
  # to the conversation. So we stream the message as it is being generated.
  after_create_commit -> { created! }
  after_update_commit -> { updated! }

  delegate :dom_id, to: ActionView::RecordIdentifier

  def identity
    "#{dom_id(conversation)}_messages"
  end

  private

  def created!
    broadcast_append_later_to(
      identity,
      partial: 'messages/message',
      locals: { message: self, scroll_to: true },
      target: identity
    )
  end

  def updated!
    broadcast_append_to(
      identity,
      partial: 'messages/message',
      locals: { message: self, scroll_to: true },
      target: identity
    )
  end
end
