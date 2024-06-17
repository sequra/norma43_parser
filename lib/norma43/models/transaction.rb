# frozen_string_literal: true

require "virtus"

module Norma43
  module Models
    class Transaction
      include Virtus.model

      attribute :origin_branch_code
      attribute :transaction_date
      attribute :value_date
      attribute :shared_item
      attribute :own_item
      attribute :amount_code
      attribute :amount
      attribute :document_number
      attribute :reference_1
      attribute :reference_2
      attribute :additional_items, Array[AdditionalItem]
      attribute :additional_currency, AdditionalCurrency
      def debit?; self.amount_code == DEBIT_CODE end
    end
  end
end
