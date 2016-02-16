require "norma43/line_parsers/line_parsers"

module Norma43
  module LineParsers
    RSpec.describe Transaction do
      let :transaction do

        Transaction.new "2256781127040805040805020092000000000012340000000000000000000000           REF 2"
      end

      it "parses the origin branch code" do
        expect(transaction.origin_branch_code).to eq 1127
      end

      it "parses the transaction date" do
        expect(transaction.transaction_date).to be_a Date
        expect(transaction.transaction_date.to_s).to eq "2004-08-05"
      end

      it "parses the value date" do
        expect(transaction.value_date).to be_a Date
        expect(transaction.value_date.to_s).to eq "2004-08-05"
      end

      it "parses the shared item" do
        expect(transaction.shared_item).to eq 2
      end

      it "parses the own item" do
        expect(transaction.own_item).to eq 9
      end

      it "parses the amount_code" do
        expect(transaction.amount_code).to eq 2
      end

      it "parses the amount" do
        expect(transaction.amount).to eq 1234
      end

      it "parses the document number" do
        expect(transaction.document_number).to eq 0
      end

      it "parses the reference 1" do
        expect(transaction.reference_1).to eq 0
      end

      it "parses the reference 2" do
        expect(transaction.reference_2).to eq "REF 2"
      end
    end
  end
end

