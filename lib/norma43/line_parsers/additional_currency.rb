module Norma43
  module LineParsers
    class AdditionalCurrency < LineParser
      field :data_code, 2..3, :integer
      field :currency_code, 4..6, :integer
      field :amount, 7..20, :integer
      field :free, 21..79
    end
  end
end
