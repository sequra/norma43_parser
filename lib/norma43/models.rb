# frozen_string_literal: true

require "virtus"

module Norma43
  module Models
    # forward declarations
    class Account; end
    class Transaction; end
    class AdditionalItem; end
    class AdditionalCurrency; end
    DEBIT_CODE = 1
    CREDIT_CODE = 2

    class Document
      include Virtus.model

      attribute :id
      attribute :created_at
      attribute :delivery_number
      attribute :file_type
      attribute :name
      attribute :number_of_lines
      attribute :accounts, Array[Account]

      def transaction_date
        accounts.map(&:date).compact.first
      end
    end

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
        return nil if [bank_code, branch_code, account_number].any?(&:nil?)
        return @iban unless @iban.nil?
        country_code = "ES"
        country_number = country_code.chars.map { |char| char.to_i(36) }.join
        ccc = calculate_ccc(bank_code.to_i, branch_code.to_i, account_number.to_i)
        number_to_checksum = "#{ccc}#{country_number}00".to_i
        international_checksum = calculate_iban_checksum_number(number_to_checksum)

        @iban = sprintf("%{country_code}%<checksum_number>02d%{ccc}",
          country_code: country_code,
          checksum_number: international_checksum,
          ccc: ccc)
      end

      private
        def calculate_ccc(bank_code, branch_code, account_number)
          bank_with_branch_number = (bank_code * 10**4) + branch_code

          bank_with_branch_check_digit, account_number_check_digit = [
            bank_with_branch_number,
            account_number
          ].map { |number| calculate_spanish_checksum_digit(number) }

          checksum_number = bank_with_branch_check_digit * 10 + account_number_check_digit

          sprintf("%<bank_code>04d%<branch_code>04d%<checksum_number>02d%<account_number>010d",
            bank_code: bank_code,
            branch_code: branch_code,
            checksum_number: checksum_number,
            account_number: account_number)
        end

        def calculate_spanish_checksum_digit(number)
          modulus = 11
          # Sorted by order of magnitude: units, tens, hundreds, thousands, etc.
          digit_weights = [6, 3, 7, 9, 10, 5, 8, 4, 2, 1].freeze

          reminder = digit_weights.map.with_index { |weight, order_of_magnitude|
            digit_at_position = (number / 10**order_of_magnitude) % 10

            digit_at_position * weight
          }.sum % modulus

          return reminder if reminder.zero? || reminder == 1
          modulus - reminder
        end

        def calculate_iban_checksum_number(number)
          modulus = 97
          (modulus + 1) - (number % modulus)
        end
    end

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

    class AdditionalItem
      include Virtus.model

      attribute :data_code
      attribute :item_1
      attribute :item_2
    end

    class AdditionalCurrency
      include Virtus.model

      attribute :data_code
      attribute :currency_code
      attribute :amount
      attribute :free
    end
  end
end
