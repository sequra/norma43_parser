require "norma43/line_parsers/line_parser"

module Norma43
  module LineParsers
    class DocumentStart < LineParser
      field :id, 2..13
      field :created_at, 14..33, :time
      field :delivery_number, 34..35, :integer
      field :file_type, 36..38
      field :name, 39..48
    end

    class DocumentEnd < LineParser
      field :record_number, 20..25, :integer
    end

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

    class Transaction < LineParser
      field :origin_branch_code, 6..9, :integer
      field :transaction_date, 10..15, :date
      field :value_date, 16..21, :date
      field :shared_item, 22..23, :integer
      field :own_item, 24..26, :integer
      field :amount_code, 27, :integer
      field :amount, 28..41, :integer
      field :document_number, 42..51, :integer
      field :reference_1, 52..63, :integer
      field :reference_2, 64..79
    end

    class AdditionalItem < LineParser
      field :data_code, 2..3, :integer
      field :item_1, 4..41
      field :item_2, 42..79
    end

    class AdditionalCurrency < LineParser
      field :data_code, 2..3, :integer
      field :currency_code, 4..6, :integer
      field :amount, 7..20, :integer
      field :free, 21..79
    end
  end
end
