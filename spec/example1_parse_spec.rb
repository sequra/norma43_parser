# frozen_string_literal: true

require "norma43"

RSpec.describe Norma43 do
  describe "parse" do
    let(:document) do
      file = File.open(File.join(__dir__, "fixtures/example1.n43"),
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
          "bank_code"             => 9999,
          "branch_code"           => 1111,
          "account_number"        => 123456789,
          "start_date"            => Date.parse("2004-08-04"),
          "end_date"              => Date.parse("2004-09-05"),
          "currency_code"         => 1,
          "information_mode_code" => 3,
          "abbreviated_name"      => "MY ACCOUNT"
        )
      end

      it "stores expected attributes from AccountEnd parser" do
        expect(account).to have_attributes(
          "balance_code"   => 2,
          "balance_amount" => 78889999999999,
          "debit_entries"  => 4,
          "debit_amount"   => 4936,
          "credit_entries" => 2,
          "credit_amount"  => 999999,
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
              "origin_branch_code" => 6700,
              "transaction_date"   => Date.parse("2004-04-08"),
              "value_date"         => Date.parse("2004-04-08"),
              "shared_item"        => 4,
              "own_item"           => 7,
              "amount_code"        => 2,
              "amount"             => 1234,
              "document_number"    => 0,
              "reference_1"        => 0,
              "reference_2"        => nil,
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
              "item_1"    => "XXXXXXXXX",
              "item_2"    => nil
            )
          end
        end

        describe "first additional currency" do
          xit "stores expected attributes" do
            # We don't have exaples to write test write when have
          end
        end
      end
    end
  end
end
