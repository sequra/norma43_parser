require "norma43/line_parsers/line_parser"
module Norma43
  class FileFormatValidator < LineParser
    field :record_type, 0..1, :raw
    field :file_type, 36..38

    def has_document?; file_type=="00" end

    def valid?
      errors.empty?
    end

    def errors
      errors = []
      %w(11 00).include? record_type or errors << "Must start with 00 (was ”#{record_type}”)"
      errors
    end
  end
end
