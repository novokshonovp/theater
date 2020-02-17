# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Cmd::Shows::CreateShow do
  let(:schedule_overlaps_query) { class_double(QueryObjects::Shows::IsScheduleOverlaps) }
  let(:start_date) { '02.02.2020' }
  let(:end_date) { '03.02.2020' }
  let(:name) { 'fake_name' }

  subject do
    described_class.run!(name: name, start_date: start_date, end_date: end_date,
                         schedule_overlaps_query: schedule_overlaps_query)
  end

  context 'when a schedule doesnt overlaps' do
    before do
      allow(schedule_overlaps_query).to receive(:call).and_return(false)
    end

    it 'should create record in a schedule' do
      expect { subject }.to change(Show, :count).by(1)
    end

    it 'should return a show' do
      is_expected.to eq(Show.last)
    end
  end

  context 'when a schedule overlaps' do
    before do
      allow(schedule_overlaps_query).to receive(:call).and_return(true)
    end

    it 'should raise an exception' do
      expect { subject }.to raise_error(Cmd::CmdError)
    end
  end
end
