# frozen_string_literal: true

module Norma43
  module LineParsers
    class DocumentStart < LineParser
      field :id, 2..13
      field :created_at, 14..33, :time
      field :delivery_number, 34..35, :integer
      field :file_type, 36..38
      field :name, 39..48
    end
  end
end
