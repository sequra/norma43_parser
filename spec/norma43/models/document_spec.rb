# frozen_string_literal: true

module Norma43
  module Models
    RSpec.describe Document do
      it_behaves_like "a model"

      describe "#transaction_date" do
        it { is_expected.to respond_to(:transaction_date) }

        context "when there are no accounts" do
          subject(:document) { described_class.new({ accounts: [] }) }

          it { expect(document.transaction_date).to be_nil }
        end

        context "when there are accounts" do
          subject(:document) { described_class.new({ accounts: [account] }) }

          let(:account) {
            Account.new(transactions: [
              nil,
              Transaction.new(transaction_date: nil),
              Transaction.new(transaction_date: Date.parse("2024-01-23")),
            ])
          }

          it "returns the date of the first account with a transaction date" do
            expect(document.transaction_date).to eq(Date.parse("2024-01-23"))
          end
        end
      end
    end
  end
end
