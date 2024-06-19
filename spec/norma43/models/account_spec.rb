# frozen_string_literal: true

module Norma43
  module Models
    RSpec.describe Account do
      it_behaves_like "a model"

      describe "#iban" do
        it { is_expected.to respond_to(:iban) }

        context "with the example in the documentation" do
          it "returns the correct IBAN string" do
            account = subject
            account.account_number = 1234567
            account.bank_code = 81
            account.branch_code = 54

            expect(account.iban).to eq("ES5400810054180001234567")
          end
        end

        context "with missing bank data" do
          subject { described_class.new.iban }
          it { is_expected.to be_nil }
        end

        context "with missing bank code" do
          subject { described_class.new(bank_code: nil, branch_code: 1234, account_number: 1234).iban }
          it { is_expected.to be_nil }
        end

        context "with missing branch code" do
          subject { described_class.new(bank_code: 1234, branch_code: nil, account_number: 1234).iban }
          it { is_expected.to be_nil }
        end

        context "with missing account number" do
          subject { described_class.new(bank_code: 1234, branch_code: 1234, account_number: nil).iban }
          it { is_expected.to be_nil }
        end

        context "with negative account number" do
          subject { described_class.new(bank_code: 1234, branch_code: 1234, account_number: -1234).iban }
          it { is_expected.to be_nil }
        end

        context "with an account number which is too large" do
          subject { described_class.new(bank_code: 1234, branch_code: 1234, account_number: 1*10**10).iban }
          it { is_expected.to be_nil }
        end
      end
    end
  end
end
