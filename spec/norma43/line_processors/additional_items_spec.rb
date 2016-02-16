require "norma43/utils/contexts"
require "norma43/line_processors"

module Norma43
  module LineProcessors
    RSpec.describe "AdditionalItems" do
      let(:line){ double "Line", attributes: {} }
      let(:transaction){ Models::Transaction.new }
      let(:contexts){ Contexts.new(
        [
          Models::Document.new ,
          Models::Account.new ,
          transaction
        ])
      }

      it "instantiates a new AdditionalItem with the line attributes" do
        allow(Models::AdditionalItem).to receive :new

        AdditionalItem.call line, contexts

        expect(Models::AdditionalItem).to have_received(:new).with line.attributes
      end

      context "when AdditionalItem is called" do
        let(:fake_additional_item) { double "Models::AdditionalItem" }
        before do
          allow(Models::AdditionalItem).to receive(:new) { fake_additional_item }
        end
        let!(:subject) { AdditionalItem.call line, contexts }

        it "adds the AdditionalItem to the account" do
          expect(transaction.additional_items).to include fake_additional_item
        end

        it "transaction is still the current contexts" do
          expect(subject.current).to be transaction
        end
      end
    end
  end
end
