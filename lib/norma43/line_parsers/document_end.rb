module Norma43
  module LineParsers
    class DocumentEnd < LineParser
      field :record_number, 20..25, :integer
    end
  end
end
