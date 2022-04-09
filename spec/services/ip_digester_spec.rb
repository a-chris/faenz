require 'rails_helper'

RSpec.describe IpDigester do
  describe '.call' do
    let(:ip) { Faker::Internet.ip_v4_address }

    context 'when same day' do
      before(:each) { allow(Time).to receive(:now).and_return(Time.new(2022, 1, 1)) }
      it 'returns same digests for the same IP' do
        first_digest = described_class.call(ip: ip)
        expect(first_digest.length).to eq(64)
        second_digest = described_class.call(ip: ip)
        expect(second_digest).to eq(first_digest)
      end
    end

    context 'when different days' do
      it 'returns different digests for the same IP' do
        allow(Time).to receive(:now).and_return(Time.new(2022, 1, 1))
        first_digest = described_class.call(ip: ip)
        expect(first_digest.length).to eq(64)
        allow(Time).to receive(:now).and_return(Time.new(2022, 1, 2))
        second_digest = described_class.call(ip: ip)
        expect(second_digest.length).to eq(64)
        expect(second_digest).not_to eq(first_digest)
      end
    end
  end
end
