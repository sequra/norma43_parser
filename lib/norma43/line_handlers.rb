# frozen_string_literal: true

module Norma43
  module LineHandlers
    def self.mapping
      {
        "00" => self.document_start,
        "88" => self.document_end,
        "11" => self.account_start,
        "33" => self.account_end,
        "22" => self.transaction,
        "23" => self.additional_item,
        "24" => self.additional_currency
      }
    end

    def self.document_start
      Handler.new LineParsers::DocumentStart, LineProcessors::DocumentStart
    end

    def self.document_end
      Handler.new LineParsers::DocumentEnd, LineProcessors::DocumentEnd
    end

    def self.account_start
      Handler.new LineParsers::AccountStart, LineProcessors::AccountStart
    end

    def self.account_end
      Handler.new LineParsers::AccountEnd, LineProcessors::AccountEnd
    end

    def self.transaction
      Handler.new LineParsers::Transaction, LineProcessors::Transaction
    end

    def self.additional_item
      Handler.new LineParsers::AdditionalItem, LineProcessors::AdditionalItem
    end

    def self.additional_currency
      Handler.new LineParsers::AdditionalCurrency, LineProcessors::AdditionalCurrency
    end

    Handler = Struct.new :parser, :processor do
      def process(line, contexts)
        line_parser = self.parser.new(line)

        processor.call line_parser, contexts
      end
    end
  end
end
