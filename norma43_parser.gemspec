# frozen_string_literal: true

lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "norma43/version"

Gem::Specification.new do |spec|
  spec.name          = "norma43_parser"
  spec.version       = Norma43::VERSION
  spec.authors       = ["Sequra engineering"]
  spec.email         = ["dev@sequra.es"]
  spec.summary       = "Parses banks transactions files specified in rule 43"
  spec.homepage      = "https://github.com/sequra/norma43_parser"
  spec.license       = "MIT"

  spec.required_ruby_version = ">= 2.7"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_runtime_dependency "virtus",   "~> 1.0"
  spec.add_runtime_dependency "zeitwerk", "~> 2.0"

  spec.add_development_dependency "rake",  "~> 13.0"
  spec.add_development_dependency "rspec", "~> 3.9"
end
