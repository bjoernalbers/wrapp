# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'wrapp/version'

Gem::Specification.new do |spec|
  spec.name          = 'wrapp'
  spec.version       = Wrapp::VERSION
  spec.authors       = ["Björn Albers"]
  spec.email         = ["bjoernalbers@googlemail.com"]
  spec.description   = %q{Wrap an App... in a disk image (DMG)}
  spec.summary       = "#{spec.name}-#{spec.version}"
  spec.homepage      = 'https://github.com/bjoernalbers/wrapp'
  spec.license       = 'MIT'
  spec.platform      = Gem::Platform::CURRENT

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ['lib']

  spec.add_dependency 'plist', '~> 3.1'

  spec.add_development_dependency 'bundler', '~> 1.3'
  spec.add_development_dependency 'rake'
  spec.add_development_dependency 'guard', '~> 1.8'
  spec.add_development_dependency 'guard-cucumber'
  spec.add_development_dependency 'guard-rspec'
  spec.add_development_dependency 'aruba'
end
