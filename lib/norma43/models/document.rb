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

      def transaction_date
        accounts.map(&:date).compact.first
      end
    end
  end
end
