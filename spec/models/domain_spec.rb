# frozen_string_literal: true

require "rails_helper"

RSpec.describe Domain do
  describe "validations" do
    context "bar_url is valid" do
      [
        "http://localhost:3000",
        "http://localhost:3000/assets/controllers/application.js",
        "https://localhost:3000",
        "https://mydomain.com",
        "http://sub.mydomain.com",
        "https://sub.mydomain.com",
        "https://www.mydomain.com",
        "https://www.mydomain.com/random",
        "https://www.mydomain.com/random"
      ].each do |base_url|
        it "works with #{base_url}" do
          domain = build(:domain, base_url:)
          debugger unless domain.valid?
          expect(domain).to be_valid
        end
      end
    end

    context "bar_url is not valid" do
      [
        "mydomain.com",
        "sub.mydomain.com",
        "www.mydomain.com/random",
      ].each do |base_url|
        it "works with #{base_url}" do
          domain = build(:domain, base_url:)
          expect(domain).not_to be_valid
        end
      end
    end
  end

  describe "cleans url" do
    [
      { value: "http://localhost:3000", expected: "localhost" },
      { value: "http://localhost:3000/assets/controllers/application.js", expected: "localhost" },
      { value: "https://localhost:3000", expected: "localhost" },
      { value: "mydomain.com", expected: "mydomain.com" },
      { value: "https://mydomain.com", expected: "mydomain.com" },
      { value: "sub.mydomain.com", expected: "sub.mydomain.com" },
      { value: "http://sub.mydomain.com", expected: "sub.mydomain.com" },
      { value: "https://sub.mydomain.com", expected: "sub.mydomain.com" },
      { value: "https://www.mydomain.com", expected: "mydomain.com" },
      { value: "www.mydomain.com/random", expected: "mydomain.com" },
      { value: "https://www.mydomain.com/random", expected: "mydomain.com" },
      { value: "https://www.mydomain.com/random", expected: "mydomain.com" }
    ].each do |i|
      it "works with #{i[:value]}" do
        expect(Domain.hotname(i[:value])).to eq i[:expected]
      end
    end
  end
end
