# -*- encoding: utf-8 -*-
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'mixlevpixle/version'

Gem::Specification.new do |gem|
  gem.name          = "mixlevpixle"
  gem.version       = Mixlevpixle::VERSION
  gem.authors       = ["Frantisek Havluj"]
  gem.email         = ["moskyt@rozhled.cz"]
  gem.description   = %q{Simple cache for day-to-day development}
  gem.summary       = %q{Simple cache for day-to-day development}
  gem.homepage      = "http://orf.ujv.cz"

  gem.files         = `git ls-files`.split($/)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.require_paths = ["lib"]
  
  gem.add_dependency 'dalli'
end
