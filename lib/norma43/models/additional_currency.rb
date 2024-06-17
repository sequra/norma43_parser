# frozen_string_literal: true

require "virtus"

module Norma43
  module Models
    class AdditionalCurrency
      include Virtus.model

      attribute :data_code
      attribute :currency_code
      attribute :amount
      attribute :free
    end
  end
end
