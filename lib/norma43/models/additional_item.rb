# frozen_string_literal: true

require "virtus"

module Norma43
  module Models
    class AdditionalItem
      include Virtus.model

      attribute :data_code
      attribute :item_1
      attribute :item_2
    end
  end
end
