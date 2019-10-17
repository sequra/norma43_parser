module Norma43
  module LineProcessors
    RSpec.describe AccountEnd do
      let :line do
        double "Line", attributes: {}
      end

      let(:account){ Norma43::Models::Account.new }
      let(:contexts){ Norma43::Utils::Contexts.new(
        [
          Norma43::Models::Document.new,
          account,
          Norma43::Models::Transaction.new
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
