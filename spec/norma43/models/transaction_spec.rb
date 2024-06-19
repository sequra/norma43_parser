# frozen_string_literal: true

module Norma43
  module Models
    RSpec.describe Transaction do
      it_behaves_like "a model"

      describe "#debit?" do
        it { is_expected.to respond_to(:debit?) }

        context "when amount code is code for debits" do
          subject(:transaction) { described_class.new(amount_code: 1) }

          it { expect(transaction.debit?).to be_truthy }
        end

        context "when amount code is code for credits" do
          subject(:transaction) { described_class.new(amount_code: 2) }

          it { expect(transaction.debit?).to be_falsey }
        end
      end
    end
  end
end
