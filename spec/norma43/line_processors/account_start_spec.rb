module Norma43
  module LineProcessors
    RSpec.describe "AccountStart" do
      let(:line){ double "Line", attributes: {} }
      let(:document) { Norma43::Models::Document.new }
      let(:contexts){ Norma43::Utils::Contexts.new }

      before do
        contexts.add document
      end

      it "instantiates a new account with the line attributes" do
        allow(Norma43::Models::Account).to receive :new

        AccountStart.call line, contexts

        expect(Norma43::Models::Account).to have_received(:new).with line.attributes
      end

      context "when AccountStart is called" do
        let(:fake_account) { double "Norma43::Models::Account" }
        before do
          allow(Norma43::Models::Account).to receive(:new) { fake_account }
        end
        let!(:subject) { AccountStart.call line, contexts }

        it "adds the account to the document" do
          expect(document.accounts).to include fake_account
        end

        it "sets the account as the current context" do
          expect(subject.current).to be fake_account
        end
      end
    end
  end
end
