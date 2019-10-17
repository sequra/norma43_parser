# frozen_string_literal: true

require "norma43"

RSpec.describe Norma43 do
  describe "#parse" do
    it "returns the parser results" do
      text = "some total-in text"
      parser = double "Parser", result: "result"
      expect(Norma43::Parser).to receive(:new).with(text) { parser }

      expect(Norma43.parse(text)).to eq "result"
    end
  end
end
