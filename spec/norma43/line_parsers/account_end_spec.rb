# frozen_string_literal: true

module Norma43
  module LineParsers
    RSpec.describe AccountEnd do
      let :account_end do
        AccountEnd.new "3399991111012345678900004000000000049360000200000000999999278889999999999001    "
      end

      it "parses the bank code" do
        expect(account_end.bank_code).to eq 9999
      end

      it "parses the branch code" do
        expect(account_end.branch_code).to eq 1111
      end

      it "parses the account number" do
        expect(account_end.account_number).to eq 123456789
      end

      it "parses the number of debit entries" do
        expect(account_end.debit_entries).to eq 4
      end

      it "parses the total of debit amounts" do
        expect(account_end.debit_amount).to eq 4936
      end

      it "parses the number of credit entries" do
        expect(account_end.credit_entries).to eq 2
      end

      it "parses the total of credit amounts" do
        expect(account_end.credit_amount).to eq 999999
      end

      it "parses the final balance code" do
        expect(account_end.balance_code).to eq 2
      end

      it "parses the final balance amount" do
        expect(account_end.balance_amount).to eq 78889999999999
      end

      it "parses the currency code" do
        expect(account_end.currency_code).to eq 1
      end
    end
  end
end
