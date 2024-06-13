# frozen_string_literal: true

module Norma43
  module Models
    class Account
      class SpanishIban
        COUNTRY_CODE = "ES"
        BANK_CODE_RANGE = BRANCH_CODE_RANGE = 0..9999
        MAX_BANK_CODE_SIZE = MAX_BRANCH_CODE_SIZE = 4
        ACCOUNT_NUMBER_RANGE = 0..9_999_999_999
        IBAN_MODULUS = 97
        IBAN_FORMAT_STRING = "%{country_code}%<checksum_number>02d%{ccc}"
        CCC_MODULUS = 11
        CCC_FORMAT_STRING = "%<bank_code>04d%<branch_code>04d%<checksum_number>02d%<account_number>010d"
        CCC_WEIGHTS = [6, 3, 7, 9, 10, 5, 8, 4, 2, 1].freeze # Sorted by order of magnitude: units, tens, hundreds, etc.

        def self.from(account)
          new(account).to_s
        end

        def initialize(account)
          @bank_code = account.bank_code
          @branch_code = account.branch_code
          @account_number = account.account_number
        end

        def to_s
          return nil unless BANK_CODE_RANGE.include?(bank_code)
          return nil unless BRANCH_CODE_RANGE.include?(branch_code)
          return nil unless ACCOUNT_NUMBER_RANGE.include?(account_number)

          iban
        end

        private
          attr_reader :bank_code, :branch_code, :account_number

          def iban
            format_string = IBAN_FORMAT_STRING
            country_code = COUNTRY_CODE
            country_number = calculate_country_number
            ccc = calculate_ccc
            number = "#{ccc}#{country_number}00".to_i
            checksum_number = calculate_iban_checksum_number(number)

            sprintf(format_string,
              country_code: country_code,
              checksum_number: checksum_number,
              ccc: ccc)
          end

          def calculate_country_number
            COUNTRY_CODE.chars.map { |char| char.to_i(36) }.join
          end

          def calculate_ccc
            format_string = CCC_FORMAT_STRING
            bank_with_branch_number = (bank_code * 10**MAX_BRANCH_CODE_SIZE) + branch_code

            bank_with_branch_check_digit, account_number_check_digit = [
              bank_with_branch_number, account_number
            ].map { |number| calculate_spanish_checksum_digit(number) }

            checksum_number = bank_with_branch_check_digit * 10 + account_number_check_digit

            sprintf(format_string,
              bank_code: bank_code,
              branch_code: branch_code,
              checksum_number: checksum_number,
              account_number: account_number)
          end

          def calculate_spanish_checksum_digit(number)
            modulus = CCC_MODULUS

            reminder = CCC_WEIGHTS.map.with_index { |weight, order_of_magnitude|
              digit_at_position = (number / 10**order_of_magnitude) % 10

              digit_at_position * weight
            }.sum % modulus

            return reminder if reminder.zero? || reminder == 1
            modulus - reminder
          end

          def calculate_iban_checksum_number(number)
            modulus = IBAN_MODULUS
            (modulus + 1) - (number % modulus)
          end
      end
    end
  end
end
