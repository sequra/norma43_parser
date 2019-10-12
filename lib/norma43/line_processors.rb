module Norma43
  module LineProcessors
    DocumentStart = ->(line, contexts) {
      document = Models::Document.new line.attributes

      contexts.add document

      contexts
    }

    DocumentEnd = ->(line, contexts) {
      contexts.move_to Models::Document
      contexts.current.number_of_lines = line.record_number
      contexts
    }

    AccountStart = ->(line, contexts) {
      contexts.move_to Models::Document
      account = Models::Account.new line.attributes
      contexts.current.accounts << account
      contexts.add account

      contexts
    }

    AccountEnd = ->(line, contexts) {
      contexts.move_to Models::Account
      contexts.current.attributes = line.attributes
      contexts
    }

    Transaction = ->(line, contexts) {
      contexts.move_to Models::Account

      transaction = Models::Transaction.new line.attributes

      contexts.current.transactions << transaction

      contexts.add transaction

      contexts
    }

    AdditionalItem = ->(line, contexts) {
      contexts.move_to Models::Transaction
      additional_item = Models::AdditionalItem.new line.attributes
      contexts.current.additional_items << additional_item
      contexts
    }

    AdditionalCurrency = ->(line, contexts) {
      contexts.move_to Models::Transaction
      additional_currency = Models::AdditionalCurrency.new line.attributes
      contexts.current.additional_currency = additional_currency
      contexts
    }
  end
end
