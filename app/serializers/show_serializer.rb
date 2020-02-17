# frozen_string_literal: true

class ShowSerializer < ActiveModel::Serializer
  attributes :id, :name, :schedule

  def schedule
    "#{date_format(object.schedule.first)}-#{date_format(object.schedule.last)}"
  end

  private

  def date_format(date)
    date.strftime('%d.%m.%Y')
  end
end
