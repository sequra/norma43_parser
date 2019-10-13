# frozen_string_literal: true

require "time"

module Norma43
  module Utils
    module Typecaster
      def self.cast(value, type)
        casters.fetch(type).call(value) unless value == ""
      end

      def self.casters
        {
          integer: ->(value) { value.to_i },
          time: ->(value) { Time.strptime(value, "%Y%m%d%H%M%S%N") },
          date: ->(value) { Date.strptime(value, "%y%m%d") },
          string: ->(value) { value unless value.match?(/\A0+\Z/) },
          raw: ->(value) { value }
        }
      end
    end
  end
end
