# frozen_string_literal: true

module Norma43
  module Models
    RSpec.describe Account do
      describe "#iban" do
        it { is_expected.to respond_to :iban }

        context "with the example in the documentation" do
          it "delegates to SpanishIban to return a IBAN string" do
            account = subject
            allow(Account::SpanishIban).to receive(:from_account).with(account).and_return("ES0000000000000000000123")
            expect(account.iban).to eq("ES0000000000000000000123")
            expect(Account::SpanishIban).to have_received(:from_account).with(account)
          end
        end
      end
    end
  end
end
