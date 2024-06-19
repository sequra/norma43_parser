# frozen_string_literal: true

module Norma43
  module Models
    class AdditionalCurrency
      include Mixins::AttributesAssignment

      attr_accessor :data_code, :currency_code, :amount, :free

      def initialize(attributes = EMPTY_ATTRIBUTES)
        @data_code,
        @currency_code,
        @amount,
        @free = Hash(attributes).values_at(
          :data_code,
          :currency_code,
          :amount,
          :free)
      end
    end
  end
end
