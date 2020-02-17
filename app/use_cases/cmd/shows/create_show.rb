# frozen_string_literal: true

module Cmd
  module Shows
    class CreateShow < Cmd::Base
      interface :schedule_overlaps_query, default: QueryObjects::Shows::IsScheduleOverlaps

      string :name
      date :start_date
      date :end_date

      def execute
        validate_policies!

        Show.create!(name: name, schedule: start_date..end_date)
      end

      private

      def validate_policies!
        raise Cmd::CmdError, OpenStruct.new(errors: { base: 'Date reserved' }) if date_reserved?
      end

      def date_reserved?
        schedule_overlaps_query.call(start_date: start_date, end_date: end_date)
      end
    end
  end
end
