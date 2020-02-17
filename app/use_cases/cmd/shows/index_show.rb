# frozen_string_literal: true

module Cmd
  module Shows
    class IndexShow < Cmd::Base
      def execute
        Show.all
      end
    end
  end
end
