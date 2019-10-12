require "virtus"

module Norma43
  module Models
    #forward declarations
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
      def debit?; self.amount_code==DEBIT_CODE end
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
