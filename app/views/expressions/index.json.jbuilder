# frozen_string_literal: true

json.expressions do
  json.array! @expressions do |expression|
    json.body expression.body

    json.definitions do
      json.array! expression.definitions do |definition|
        json.body definition.body
      end
    end

    json.quotes do
      json.array! expression.quotes do |quote|
        json.body quote.body
      end
    end
  end
end
