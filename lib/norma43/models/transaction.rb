# frozen_string_literal: true

module Norma43
  module Models
    class Transaction
      include Mixins::AttributesAssignment

      attr_accessor :origin_branch_code,
        :transaction_date,
        :value_date,
        :shared_item,
        :own_item,
        :amount_code,
        :amount,
        :document_number,
        :reference_1,
        :reference_2,
        :additional_items,
        :additional_currency

      def initialize(attributes = EMPTY_ATTRIBUTES)
        @origin_branch_code,
        @transaction_date,
        @value_date,
        @shared_item,
        @own_item,
        @amount_code,
        @amount,
        @document_number,
        @reference_1,
        @reference_2,
        additional_items,
        additional_currency = Hash(attributes).values_at(
          :origin_branch_code,
          :transaction_date,
          :value_date,
          :shared_item,
          :own_item,
          :amount_code,
          :amount,
          :document_number,
          :reference_1,
          :reference_2)
        @additional_items = Array(additional_items).map { |attrs| AdditionalItem.new(attrs) }
        @additional_currency = AdditionalCurrency.new(additional_currency) if additional_currency
      end

      def debit?; self.amount_code == DEBIT_CODE end
    end
  end
end
