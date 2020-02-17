# frozen_string_literal: true

module Contracts
  module Shows
    class DeleteShow < Contracts::Base
      params do
        required(:id).value(:integer)
      end
    end
  end
end
