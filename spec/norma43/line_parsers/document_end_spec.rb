module Norma43
  module LineParsers
    RSpec.describe DocumentEnd do
      let :document_end do
        DocumentEnd.new "88999999999999999999000048                                                      "
      end

      it "parses the record number" do
        expect(document_end.record_number).to eq 48
      end

    end
  end
end
