require "norma43/utils/contexts"
require "norma43/line_processors"

module Norma43
  module LineProcessors
    RSpec.describe "AdditionalCurrency" do
      let(:line){ double "Line", attributes: {} }
      let(:transaction){ Models::Transaction.new }
      let(:contexts){ Contexts.new(
        [
          Models::Document.new ,
          Models::Account.new ,
          transaction
        ])
      }

      it "instantiates a new AdditionalCurrency with the line attributes" do
        allow(Models::AdditionalCurrency).to receive :new

        AdditionalCurrency.call line, contexts

        expect(Models::AdditionalCurrency).to have_received(:new).with line.attributes
      end

      context "when AdditionalCurrency is called" do
        let(:fake_additional_currency) { double "Models::AdditionalCurrency" }
        before do
          allow(Models::AdditionalCurrency).to receive(:new) { fake_additional_currency }
        end
        let!(:subject) { AdditionalCurrency.call line, contexts }

        it "adds the AdditionalCurrency to the account" do
          expect(transaction.additional_currency).to eq fake_additional_currency
        end

        it "transaction is still the current contexts" do
          expect(subject.current).to be transaction
        end
      end
    end
  end
end
