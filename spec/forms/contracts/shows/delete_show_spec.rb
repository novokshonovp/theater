# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Contracts::Shows::DeleteShow do
  describe '#call' do
    subject { described_class.new(params).result }

    context 'when all params are correct' do
      let(:params) { { id: 1 } }

      it 'should return success' do
        expect(subject.errors.to_h).to eq({})
      end
    end

    context 'when without id' do
      let(:params) { {} }

      it 'should return error' do
        expect(subject.errors.to_h).to include(id: ['is missing'])
      end
    end
  end
end
