# frozen_string_literal: true

module Contracts
  module Shows
    class NewShow < Contracts::Base
      params do
        required(:name).value(:string)
        required(:start_date).value(:date)
        required(:end_date).value(:date)
      end

      rule(:start_date) do
        key.failure(text: 'must be in future') if values[:start_date] < DateTime.now
        key.failure(text: 'must be later than end_date') if values[:start_date] > values[:end_date]
      end
    end
  end
end
