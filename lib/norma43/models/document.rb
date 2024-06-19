# frozen_string_literal: true

require "virtus"

module Norma43
  module Models
    class Document
      include Virtus.model

      attribute :id
      attribute :created_at
      attribute :delivery_number
      attribute :file_type
      attribute :name
      attribute :number_of_lines
      attribute :accounts, Array[Account]

      # @deprecated Please ask each transaction inside accounts for their transaction_date instead
      def transaction_date
        warn "[DEPRECATION] `transaction_date` is deprecated, use `#transaction_date` from transactions in `#accounts` instead"
        date = nil

        accounts.flat_map(&:transactions).each { |transaction|
          date = transaction&.transaction_date
          break unless date.nil?
        }

        date
      end
    end
  end
end
