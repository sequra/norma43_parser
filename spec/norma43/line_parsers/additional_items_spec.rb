module Norma43
  module LineParsers
    RSpec.describe AdditionalItem do
      let :additional_items do
        AdditionalItem.new "2301REF XXXXXXXXX                                          TRASPASO EJEMPLO     "
      end

      it "parses the data code" do
        expect(additional_items.data_code).to eq 1
      end

      it "parses the first item" do
        expect(additional_items.item_1).to eq "REF XXXXXXXXX"
      end

      it "parses the second item" do
        expect(additional_items.item_2).to eq "TRASPASO EJEMPLO"
      end
    end
  end
end
