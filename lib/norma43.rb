# frozen_string_literal: true

require "zeitwerk"

loader = Zeitwerk::Loader.for_gem
loader.setup # ready!

module Norma43
  def self.parse(text)
    Parser.new(text).result
  end
end

loader.eager_load
