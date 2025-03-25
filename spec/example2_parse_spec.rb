# frozen_string_literal: true

require "norma43"

RSpec.describe Norma43 do
  describe "parse" do
    let(:document) do
      file = File.open(File.join(__dir__, "fixtures/example2.n43"),
                        encoding: "iso-8859-1")
      Norma43.parse file
    end

    it "finds one account" do
      expect(document.accounts.size).to eq 1
    end

    describe "first account" do
      let(:account) { document.accounts.first }

      it "stores expected attributes from AccountStart parser" do
        expect(account).to have_attributes(
          "bank_code"             => 81,
          "branch_code"           => 4797,
          "account_number"        => 6995216857,
          "start_date"            => Date.parse("2025-03-17"),
          "end_date"              => Date.parse("2025-03-17"),
          "currency_code"         => 978,
          "information_mode_code" => 3,
          "abbreviated_name"      => "SEQURA WORLDWIDE S.A.",
        )
      end

      it "stores expected attributes from AccountEnd parser" do
        expect(account).to have_attributes(
          "balance_code"   => 2,
          "balance_amount" => 8614571,
          "debit_entries"  => nil,
          "debit_amount"   => nil,
          "credit_entries" => nil,
          "credit_amount"  => nil,
        )
      end

      describe "transactions" do
        it "finds all transactions" do
          expect(account.transactions.size).to eq 4
        end

        describe "first transaction" do
          let(:transaction) { account.transactions[0] }
          it "stores expected attributes" do
            expect(transaction).to have_attributes(
              "origin_branch_code" => 7013,
              "transaction_date"   => Date.parse("2025-03-17"),
              "value_date"         => Date.parse("2025-03-14"),
              "shared_item"        => 4,
              "own_item"           => 7,
              "amount_code"        => 2,
              "amount"             => 9726,
              "document_number"    => 6871166755,
              "reference_1"        => "TRANSFERENCI",
              "reference_2"        => "A48555633617",
            )
          end
        end

        it "each transaction has 5 additional_items as a maximum" do
          account.transactions.each do |transaction|
            expect(transaction.additional_items.size).to be <= 5
          end
        end

        describe "first additional item" do
          let(:additional_item) { account.transactions[0].additional_items[0] }
          it "stores expected attributes" do
            expect(additional_item).to have_attributes(
              "data_code" => 1,
              "item_1"    => "MARIA NARANJO ENFLOR",
              "item_2"    => "A48555633617"
            )
          end
        end
      end
    end
  end
end
