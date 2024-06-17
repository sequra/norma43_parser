# frozen_string_literal: true

require "virtus"

module Norma43
  module Models
    class Account
      include Virtus.model

      attribute :bank_code
      attribute :branch_code
      attribute :account_number
      attribute :start_date
      attribute :end_date
      attribute :balance_code
      attribute :balance_amount
      attribute :currency_code
      attribute :information_mode_code
      attribute :abbreviated_name
      attribute :debit_entries
      attribute :debit_amount
      attribute :credit_entries
      attribute :credit_amount
      attribute :transactions, Array[Transaction]

      def iban
        @iban ||= SpanishIban.from_account(self)
      end
    end
  end
end
