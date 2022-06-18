# frozen_string_literal: true

FactoryBot.define do
  factory :quote do
    body { "MyText" }
    source { "MyText" }
    expression { nil }
  end
end
