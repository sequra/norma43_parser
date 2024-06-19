# frozen_string_literal: true

module Norma43
  module Models
    class Document
      include Mixins::AttributesAssignment

      attr_accessor :id, :created_at, :delivery_number, :file_type, :name, :number_of_lines, :accounts

      def initialize(attributes = EMPTY_ATTRIBUTES)
        @id,
        @created_at,
        @delivery_number,
        @file_type,
        @name,
        @number_of_lines,
        accounts = Hash(attributes).values_at(
          :id,
          :created_at,
          :delivery_number,
          :file_type,
          :name,
          :number_of_lines,
          :accounts)
        @accounts = Array(accounts).map { |account| Account.new(account) }
      end

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
