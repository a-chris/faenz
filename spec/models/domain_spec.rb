# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Domain do
  describe 'cleans url' do
    [
      {value: 'http://localhost:3000', expected: 'localhost'},
      {value: 'http://localhost:3000/assets/controllers/application.js', expected: 'localhost'},
      {value: 'https://localhost:3000', expected: 'localhost'},
      {value: 'mydomain.com', expected: 'mydomain.com'},
      {value: 'https://mydomain.com', expected: 'mydomain.com'},
      {value: 'sub.mydomain.com', expected: 'sub.mydomain.com'},
      {value: 'http://sub.mydomain.com', expected: 'sub.mydomain.com'},
      {value: 'https://sub.mydomain.com', expected: 'sub.mydomain.com'},
      {value: 'https://www.mydomain.com', expected: 'mydomain.com'},
      {value: 'www.mydomain.com/random', expected: 'mydomain.com'},
      {value: 'https://www.mydomain.com/random', expected: 'mydomain.com'},
      {value: 'https://www.mydomain.com/random', expected: 'mydomain.com'},
    ].each do |i|
      it "works with #{i[:value]}" do
        expect(Domain.hotname(i[:value])).to eq i[:expected]
      end
    end
  end
end
