require "norma43/version"
require "norma43/parser"

module Norma43
  def self.parse text
    Parser.new(text).result
  end
end
