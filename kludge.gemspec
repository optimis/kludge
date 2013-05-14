# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'kludge/version'

Gem::Specification.new do |spec|
  spec.name          = "kludge"
  spec.version       = Kludge::VERSION
  spec.authors       = ["hubert", "ryan moran"]
  spec.email         = ["hubert77@gmail.com", 'ryan.moran@gmail.com']
  spec.description   = %q{Nested attributes alternative}
  spec.summary       = %q{hello}
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_dependency 'activemodel', '>= 3.0'

  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency "rake"
  spec.add_development_dependency 'rspec'
end
