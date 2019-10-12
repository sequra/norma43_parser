module Norma43
  module LineParsers
    class AdditionalItem < LineParser
      field :data_code, 2..3, :integer
      field :item_1, 4..41
      field :item_2, 42..79
    end
  end
end
