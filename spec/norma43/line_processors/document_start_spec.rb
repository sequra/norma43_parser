module Norma43
  module LineProcessors
    RSpec.describe "DocumentStart" do
      let (:line) { double "Line", attributes: {} }

      it "instantiates a new document with the line attributes" do
        allow(Models::Document).to receive :new

        DocumentStart.call line, Norma43::Utils::Contexts.new

        expect(Models::Document).to have_received(:new).with line.attributes
      end

      it "sets the document as the current context" do
        fake_document = double "Models::Document"
        allow(Models::Document).to receive(:new) { fake_document }

        contexts = DocumentStart.call line, Norma43::Utils::Contexts.new

        expect(contexts.current).to be fake_document
      end
    end
  end
end
