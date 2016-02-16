require "norma43/parser"

module Norma43
  RSpec.describe Parser do
    describe "ensuring the file is valid" do
      it "accepts a valid file starting with document" do
        valid_file = "00TI222222    2011102504133012345601TL1Norma43                                  "
        expect{ Parser.new(valid_file) }.to_not raise_error
      end

      it "accepts a valid file starting with an account" do
        
        valid_file = "119999111101234567890408040409052000000001234569783MY ACCOUNT                   "
        expect{ Parser.new(valid_file) }.to_not raise_error
      end

      it "should start with 00 or 11" do
        invalid_file = "99TI222222    2011102504133012345601TL1Norma43                                  "
        expect{ Parser.new(invalid_file) }.to raise_error{ Norma43::InvalidFileFormatError }
      end
    end
  end
end
