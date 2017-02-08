# -*- encoding: utf-8 -*-
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'mixlevpixle/version'

Gem::Specification.new do |spec|
  spec.name          = "mixlevpixle"
  spec.version       = Mixlevpixle::VERSION
  spec.authors       = ["Frantisek Havluj"]
  spec.email         = ["moskyt@rozhled.cz"]
  spec.description   = %q{Simple cache for day-to-day development}
  spec.summary       = %q{Simple cache for day-to-day development}
  spec.homepage      = "http://orf.ujv.cz"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_dependency 'dalli'

  spec.add_development_dependency "bundler", "~> 1.12"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "minitest", "~> 5.0"
  spec.add_development_dependency "ci_reporter_minitest", "~> 1.0"

end
