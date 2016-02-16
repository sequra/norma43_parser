# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "norma43/version"

Gem::Specification.new do |spec|
  spec.name          = "norma43_parser"
  spec.version       = Norma43::VERSION
  spec.authors       = ["Sequra engineering"]
  spec.email         = ["dev@sequra.es"]
  spec.summary       = %q{Parses banks transactions files specified in rule 43}
  spec.homepage      = "https://github.com/sequra/norma43_parser"
  spec.license       = "MIT"

  spec.required_ruby_version = "~> 2.0"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.5"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "byebug"
  spec.add_development_dependency "rspec"
  spec.add_runtime_dependency "virtus"
end
