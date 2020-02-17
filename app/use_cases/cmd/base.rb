# frozen_string_literal: true

module Cmd
  class Base < ActiveInteraction::Base
    def validate_policies!(policies, entity)
      policies.each { |policy| policy.validate!(entity) }
    end
  end
end
