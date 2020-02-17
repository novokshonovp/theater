# frozen_string_literal: true

module Cmd
  module Shows
    class DeleteShow < Cmd::Base
      integer :id

      def execute
        Show.find(id)
        Show.delete(id)
      end
    end
  end
end
