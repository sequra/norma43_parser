# frozen_string_literal: true

module Norma43
  module Models
    RSpec.describe Account do
      describe "#iban pre-conditions" do
        it "responds to all the attributes needed to calculate the IBAN number" do
          is_expected.to(respond_to(:bank_code)
            .and respond_to(:branch_code)
            .and respond_to(:account_number)
          )
        end

        it { is_expected.to(respond_to(:iban)) }
      end

      describe "#iban" do
        subject(:iban) { described_class.new(attributes).iban }

        context "with the example in the documentation" do
          let(:attributes) { { "bank_code" => 81, "branch_code" => 54, "account_number" => 1234567 } }
          it { is_expected.to eq("ES5400810054180001234567") }
        end

        context "with the attributes from the example1.n43 fixture" do
          let(:attributes) {
            file.seek 2
            bank_code = file.read(4).to_i
            branch_code = file.read(4).to_i
            account_number = file.read(10).to_i
            { "bank_code" => bank_code, "branch_code" => branch_code, "account_number" => account_number }
          }
          let(:file) { File.open(File.join(__dir__, "../../fixtures/example1.n43"), encoding: "iso-8859-1") }

          it { is_expected.to eq("ES1799991111710123456789") }

          after { file.close }
        end

        context "with minimal edge-case" do
          let(:attributes) { { "bank_code" => 3, "branch_code" => 0, "account_number" => 0 } }
          it { is_expected.to eq("ES8700030000300000000000") }
        end

        context "with extreme edge-case" do
          let(:attributes) { { "bank_code" => 9000, "branch_code" => 9999, "account_number" => 9999999999 } }
          it { is_expected.to eq("ES3790009999309999999999") }
        end
      end

      describe "incorrect conditions for #iban" do
        subject(:iban) { described_class.new(attributes).iban }

        let(:attributes) { { "bank_code" => bank_code, "branch_code" => branch_code, "account_number" => account_number } }
        let(:bank_code) { 9999 }
        let(:branch_code) { 1111 }
        let(:account_number) { 123456789 }

        context "with missing bank code" do
          let(:bank_code) { nil }
          it { is_expected.to be_nil }
        end

        context "with missing branch code" do
          let(:branch_code) { nil }
          it { is_expected.to be_nil }
        end

        context "with missing account number" do
          let(:account_number) { nil }
          it { is_expected.to be_nil }
        end

        context "with negative bank code" do
          let(:bank_code) { -3 }
          it { is_expected.to be_nil }
        end

        context "with negative branch code" do
          let(:bank_code) { -1 }
          it { is_expected.to be_nil }
        end

        context "with negative account number" do
          let(:account_number) { -123456789 }
          it { is_expected.to be_nil }
        end

        context "with more than 4 digits in the bank code" do
          let(:bank_code) { 99990 }
          it { is_expected.to be_nil }
        end

        context "with more than 4 digits in the branch code" do
          let(:bank_code) { 11110 }
          it { is_expected.to be_nil }
        end

        context "with more than 10 digits in the account number" do
          let(:account_number) { 12345678900 }
          it { is_expected.to be_nil }
        end
      end
    end
  end
end
