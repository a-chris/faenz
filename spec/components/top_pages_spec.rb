require 'rails_helper'

RSpec.describe TopPages do
  describe 'initialize' do
    let(:domain) { FactoryBot.create(:domain_github) }

    context 'when domain has visits' do
      before(:each) { 10.times { |i| FactoryBot.create(:visit, domain: domain, time_at: Time.now) } }
      it 'display the pages correctly' do
        tp = TopPages.new(domain: domain, start_date: Time.now - 1.week)
        expected = {
          "page_1"=>1,
          "page_2"=>1,
          "page_3"=>1,
          "page_4"=>1,
          "page_5"=>1,
          "page_6"=>1,
          "page_7"=>1,
          "page_8"=>1,
          "page_9"=>1,
          "page_10"=>1
        }
        expect(tp.series).to eq expected
      end
    end
  end
end