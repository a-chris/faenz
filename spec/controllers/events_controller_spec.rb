require 'rails_helper'

RSpec.describe EventsController, type: :controller do
  describe 'create' do
    context 'when the domain exists' do
      before(:each) { FactoryBot.create(:domain_github) }

      it 'creates a Visit' do
        post 'create', params: { u: 'https://github.com/en', d: 'github.com', n: 'pageview', w: 994 }
        expect(response.parsed_body).to eq({ 'text' => 'ok' })
        expect(Domain.count).to eq 1
      end
    end

    context 'when the domain does not exists' do
      before(:each) { Domain.destroy_all }

      it 'creates a Visit' do
        post 'create', params: { u: 'https://github.com/en', d: 'github.com', n: 'pageview', w: 994 }
        expect(response.parsed_body).to eq({ 'text' => 'Domain not found' })
        expect(Domain.count).to eq 0
      end
    end
  end
end
