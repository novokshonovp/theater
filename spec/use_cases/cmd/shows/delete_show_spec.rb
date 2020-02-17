# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Cmd::Shows::DeleteShow do
  subject { described_class.run!(id: id) }

  context 'when a show exists' do
    let(:show) { create(:show, schedule: DateTime.parse('10.01.2020')..DateTime.parse('15.01.2020')) }
    let(:id) { show.id }

    it 'should delete a show' do
      subject

      expect(Show.find_by_id(id)).to be nil
    end
  end

  context 'when a show doesnt exist' do
    let(:id) { 100 }

    it 'should raise an exception' do
      expect { subject }.to raise_error(::ActiveRecord::RecordNotFound)
    end
  end
end
