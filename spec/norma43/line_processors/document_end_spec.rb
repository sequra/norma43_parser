# frozen_string_literal: true

module Norma43
  module LineProcessors
    RSpec.describe DocumentEnd do
      let(:line) { instance_double(LineParsers::DocumentEnd, record_number: 35) }

      it "moves to the nearest document context" do
        document = Norma43::Models::Document.new
        contexts = Norma43::Utils::Contexts.new [anything, document, anything, anything]

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
