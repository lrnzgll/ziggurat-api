# frozen_string_literal: true

class Expression < ApplicationRecord
  validates :body, presence: true
  validates :definition, presence: true
  validates :context, presence: true
  validates :context_source, presence: true
end
