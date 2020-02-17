# frozen_string_literal: true

require 'rails_helper'

RSpec.describe ShowsController, type: :controller do
  around do |example|
    travel_to('01.01.2019 10:00') do
      example.run
    end
  end

  describe '#create' do
    context 'with right params' do
      let(:params) { { name: 'fake_name', start_date: '10.01.2020', end_date: '15.01.2020' } }

      it 'should return a show' do
        post :create, params: params

        expect(response.status).to eq 200
        expect(response).to match_json_schema('shows/show')
      end
    end

    context 'with wrong params' do
      let(:params) { { start_date: '10.01.2020', end_date: '15.01.2020' } }

      it 'should return an error' do
        post :create, params: params

        expect(response.status).to eq 422
      end
    end
  end

  describe '#index' do
    before do
      create(:show, schedule: DateTime.parse('10.01.2020')..DateTime.parse('15.01.2020'))
    end

    it 'should return shows' do
      get :index

      expect(response.status).to eq 200
      expect(response).to match_json_schema('shows/index_show', list: Show.all)
    end
  end

  describe '#delete' do
    let(:show) { create(:show, schedule: DateTime.parse('10.01.2020')..DateTime.parse('15.01.2020')) }

    context 'with right params' do
      let(:params) { { id: show.id } }

      it 'should return shows' do
        delete :destroy, params: params

        expect(response.status).to eq 200
        expect(response).to match_json_schema('shows/delete_show')
      end
    end

    context 'with wrong params' do
      let(:params) { { id: 100 } }

      it 'should return an error' do
        delete :destroy, params: params

        expect(response.status).to eq 404
      end
    end
  end
end
