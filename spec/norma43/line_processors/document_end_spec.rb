module Norma43
  module LineProcessors
    RSpec.describe "DocumentEnd" do
      class Thing
      end

      let(:line) { double "Line", record_number: 35 }

      it "moves to the nearest document context" do
        document = Norma43::Models::Document.new
        contexts = Norma43::Utils::Contexts.new [Thing.new, document, Thing.new, Thing.new]

        DocumentEnd.call line, contexts

        expect(contexts.current).to eq document
      end

      it "sets the number of lines on the document" do
        document = Norma43::Models::Document.new

        DocumentEnd.call line, Norma43::Utils::Contexts.new(document)

        expect(document.number_of_lines).to eq 35
      end
    end
  end
end
