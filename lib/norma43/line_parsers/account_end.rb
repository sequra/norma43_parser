module Norma43
  module LineParsers
    class AccountEnd < LineParser
      field :bank_code, 2..5, :integer
      field :branch_code, 6..9, :integer
      field :account_number, 10..19, :integer
      field :debit_entries, 20..24, :integer
      field :debit_amount, 25..38, :integer
      field :credit_entries, 39..43, :integer
      field :credit_amount, 44..57, :integer
      field :balance_code, 58, :integer
      field :balance_amount, 59..72, :integer
      field :currency_code, 73..75, :integer
    end
  end
end
