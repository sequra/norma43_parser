module Norma43
  module LineParsers
    RSpec.describe AccountStart do
      let :account_start do
        AccountStart.new "119999111101234567890408040409052000000001234569783MY ACCOUNT                   "
      end

      it "parses the bank code" do
        expect(account_start.bank_code).to eq 9999
      end

      it "parses the branch code" do
        expect(account_start.branch_code).to eq 1111
      end

      it "parses the account number" do
        expect(account_start.account_number).to eq 123456789
      end


      it "parses the start date" do
        expect(account_start.start_date).to be_a Date
        expect(account_start.start_date.to_s).to eq "2004-08-04"
      end

      it "parses the end date" do
        expect(account_start.end_date).to be_a Date
        expect(account_start.end_date.to_s).to eq "2004-09-05"
      end

      it "parses the balance code" do
        expect(account_start.balance_code).to eq 2
      end

      it "parses the balance amount" do
        expect(account_start.balance_amount).to eq 123456
      end

      it "parses the currency code" do
        expect(account_start.currency_code).to eq 978
      end

      it "parses the information mode code" do
        expect(account_start.information_mode_code).to eq 3
      end

      it "parses the abbreviated name" do
        expect(account_start.abbreviated_name).to eq "MY ACCOUNT"
      end

    end
  end
end
