require 'rails_helper'

RSpec.describe TopSources do
  describe '#initialize' do
    let(:domain) { FactoryBot.create(:domain_example) }

    it 'removes ending / from referrer' do
      FactoryBot.create(:visit, domain_id: domain.id, referrer: 'https://google.com')
      FactoryBot.create(:visit, domain_id: domain.id, referrer: 'https://google.com/')
      chart = TopSources.new(domain: domain, start_date: 1.month.ago)
      expect(chart.series).to eq({ 'https://google.com' => 2 })
    end

    it 'filders out sources with same domain as subject' do
      FactoryBot.create(:visit, domain_id: domain.id, referrer: 'https://google.com')
      FactoryBot.create(:visit, domain_id: domain.id, referrer: domain.base_url)
      chart = TopSources.new(domain: domain, start_date: 1.month.ago)
      expect(chart.series).to eq({ 'https://google.com' => 1 })
    end
  end
end
