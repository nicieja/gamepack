# frozen_string_literal: true

class ApplicationRecord < ActiveRecord::Base # :nodoc:
  primary_abstract_class

  include PrettyId

  def self.key(id)
    self.id_prefix = id
    self.id_separator = '_'

    id
  end
end
