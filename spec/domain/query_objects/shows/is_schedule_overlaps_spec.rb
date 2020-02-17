# frozen_string_literal: true

require 'rails_helper'

RSpec.describe QueryObjects::Shows::IsScheduleOverlaps do
  subject { described_class.new.call(start_date: start_date, end_date: end_date) }

  before do
    create(:show, schedule: DateTime.parse('10.01.2020')..DateTime.parse('15.01.2020'))
  end

  context 'when period end overlaps' do
    let(:start_date) { DateTime.parse('01.01.2020') }
    let(:end_date) { DateTime.parse('01.10.2020') }

    it { is_expected.to be true }
  end

  context 'when period start overlaps' do
    let(:start_date) { DateTime.parse('15.01.2020') }
    let(:end_date) { DateTime.parse('20.01.2020') }

    it { is_expected.to be true }
  end

  context 'when period before scheduled' do
    let(:start_date) { DateTime.parse('01.01.2020') }
    let(:end_date) { DateTime.parse('02.01.2020') }

    it { is_expected.to be false }
  end

  context 'when period after scheduled' do
    let(:start_date) { DateTime.parse('16.01.2020') }
    let(:end_date) { DateTime.parse('17.01.2020') }

    it { is_expected.to be false }
  end
end
