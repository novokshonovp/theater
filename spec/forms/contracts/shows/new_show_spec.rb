# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Contracts::Shows::NewShow do
  around do |example|
    travel_to('01.01.2019 10:00') do
      example.run
    end
  end

  describe '#call' do
    let(:name) { 'fake_name' }
    let(:base_params) { { name: name } }

    subject { described_class.new(base_params.merge!(params)).result }

    context 'when all params are correct' do
      let(:params) { { start_date: '19-02-2019', end_date: '21-03-2019' } }

      it 'should return success' do
        expect(subject.errors.to_h).to eq({})
      end
    end

    context 'when wrong date' do
      let(:params) { { start_date: '31-02-2019', end_date: '21-03-2019' } }

      it 'should return error' do
        expect(subject.errors.to_h).to include(start_date: ['must be a date'])
      end
    end

    context 'when wrong order' do
      let(:params) { { start_date: '21-03-2019', end_date: '19-02-2019' } }

      it 'should return error' do
        expect(subject.errors.to_h).to include(start_date: ['must be later than end_date'])
      end
    end

    context 'when start_date in past' do
      let(:params) { { start_date: '21-03-2018', end_date: '19-02-2019' } }

      it 'should return error' do
        expect(subject.errors.to_h).to include(start_date: ['must be in future'])
      end
    end

    context 'when no name supplied' do
      let(:params) { { start_date: '19-02-2019', end_date: '21-03-2019' } }

      subject { described_class.new(params).result }

      it 'should return error' do
        expect(subject.errors.to_h).to include(name: ['is missing'])
      end
    end
  end
end
