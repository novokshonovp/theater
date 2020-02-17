# frozen_string_literal: true

module QueryObjects
  module Shows
    class IsScheduleOverlaps
      def self.call(start_date:, end_date:)
        new.call(start_date: start_date, end_date: end_date)
      end

      def call(start_date:, end_date:)
        Show.where("'[#{format_date(start_date)}, #{end_date}]'::daterange && shows.schedule").exists?
      end

      private

      def format_date(date)
        date.strftime('%m-%d-%Y')
      end
    end
  end
end
