# frozen_string_literal: true

module Norma43
  module LineParsers
    class AccountStart < LineParser
      field :bank_code, 2..5, :integer
      field :branch_code, 6..9, :integer
      field :account_number, 10..19, :integer
      field :start_date, 20..25, :date
      field :end_date, 26..31, :date
      field :balance_code, 32, :integer
      field :balance_amount, 33..46, :integer
      field :currency_code, 47..49, :integer
      field :information_mode_code, 50, :integer
      field :abbreviated_name, 51..76
    end
  end
end
