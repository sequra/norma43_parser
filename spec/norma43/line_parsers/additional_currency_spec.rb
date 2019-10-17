# frozen_string_literal: true

module Norma43
  module LineParsers
    RSpec.describe AdditionalCurrency do
      let :additional_currency do
        AdditionalCurrency.new "230197802030405600040                                      TRASPASO EJEMPLO   "
      end

      it "parses the data code" do
        expect(additional_currency.data_code).to eq 1
      end

      it "parses the first item" do
        expect(additional_currency.currency_code).to eq 978
      end

      it "parses the second item" do
        expect(additional_currency.amount).to eq 2030405600040
      end

      it "parses the free" do
        expect(additional_currency.free).to eq "TRASPASO EJEMPLO"
      end
    end
  end
end
