# frozen_string_literal: true

module Norma43
  module Models
    class AdditionalItem
      include Mixins::AttributesAssignment

      attr_accessor :data_code, :item_1, :item_2

      def initialize(attributes = EMPTY_ATTRIBUTES)
        @data_code,
        @item_1,
        @item_2 = Hash(attributes).values_at(
          :data_code,
          :item_1,
          :item_2)
      end
    end
  end
end
