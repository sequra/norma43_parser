# frozen_string_literal: true

module Norma43
  module Models
    class Account
      include Mixins::AttributesAssignment

      attr_accessor :bank_code,
        :branch_code,
        :account_number,
        :start_date,
        :end_date,
        :balance_code,
        :balance_amount,
        :currency_code,
        :information_mode_code,
        :abbreviated_name,
        :debit_entries,
        :debit_amount,
        :credit_entries,
        :credit_amount,
        :transactions

      def initialize(attributes = EMPTY_ATTRIBUTES)
        @bank_code,
        @branch_code,
        @account_number,
        @start_date,
        @end_date,
        @balance_code,
        @balance_amount,
        @currency_code,
        @information_mode_code,
        @abbreviated_name,
        @debit_entries,
        @debit_amount,
        @credit_entries,
        @credit_amount,
        transactions = Hash(attributes).values_at(
          :bank_code,
          :branch_code,
          :account_number,
          :start_date,
          :end_date,
          :balance_code,
          :balance_amount,
          :currency_code,
          :information_mode_code,
          :abbreviated_name,
          :debit_entries,
          :debit_amount,
          :credit_entries,
          :credit_amount,
          :transactions)
        @transactions = Array(transactions).map { |attrs| Transaction.new(attrs) }
      end

      def iban
        SpanishIban.from_account(self)
      end
    end
  end
end
