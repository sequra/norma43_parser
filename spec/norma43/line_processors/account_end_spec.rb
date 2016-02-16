require "norma43/utils/contexts"
require "norma43/line_processors"

module Norma43
  module LineProcessors
    RSpec.describe "AccountEnd" do
      let :line do
        double "Line", attributes: {}
      end

      let(:account){ Models::Account.new }
      let(:contexts){ Contexts.new(
        [
          Models::Document.new,
          account,
          Models::Transaction.new
        ])
      }

      it "moves to the nearest account and assigns the line attributes" do
        allow(account).to receive(:attributes=)
        AccountEnd.call line, contexts
        expect(account).to have_received(:attributes=).with line.attributes
      end

      it "sets the account as the current context" do
        new_contexts = AccountEnd.call line, contexts

        expect(new_contexts.current).to be account
      end
    end
  end
end

