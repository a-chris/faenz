require 'rails_helper'

RSpec.describe Visit do
  let(:domain) { FactoryBot.create(:domain_example) }

  describe 'saving' do
    it 'cleans referrer' do
      visit = Visit.create!(domain_id: domain.id, referrer: 'http://example.com/')
      expect(visit.referrer).to eq 'http://example.com'
    end
  end
end
