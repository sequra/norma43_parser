# frozen_string_literal: true

module Norma43
  module Models
    RSpec.describe Account do
      describe "IBAN requirements" do
        it "responds to attributes needed to calculate the IBAN number" do
          is_expected.to(respond_to(:bank_code)
            .and respond_to(:branch_code)
            .and respond_to(:account_number)
          )
        end

        it "responds to IBAN" do
          is_expected.to(respond_to(:iban))
        end
      end

      describe "#iban" do
        subject(:iban) { described_class.new(attributes).iban }

        context "with missing bank code" do
          let(:attributes) { { "bank_code" => nil, "branch_code" => 1111, "account_number" => 123456789 } }
          it { is_expected.to be_nil }
        end

        context "with missing branch code" do
          let(:attributes) { { "bank_code" => 9999, "branch_code" => nil, "account_number" => 123456789 } }
          it { is_expected.to be_nil }
        end

        context "with missing account number" do
          let(:attributes) { { "bank_code" => 9999, "branch_code" => 1111, "account_number" => nil } }
          it { is_expected.to be_nil }
        end

        context "with complete attributes" do
          let(:attributes) { { "bank_code" => 81, "branch_code" => 54, "account_number" => 1234567 } }
          it { is_expected.to eq("ES5400810054180001234567") }
        end
      end
    end
  end
end
