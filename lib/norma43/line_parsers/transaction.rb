module Norma43
  module LineParsers
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
  end
end
