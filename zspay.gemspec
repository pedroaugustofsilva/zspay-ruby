# frozen_string_literal: true

$LOAD_PATH.push File.expand_path('lib', __dir__)

# Maintain your gem's version:
require 'zspay/version'

# Describe your gem and declare its dependencies:
Gem::Specification.new do |spec|
  spec.name        = 'zspay'
  spec.version     = Zspay::VERSION
  spec.authors     = ['Nullbug']
  spec.email       = ['pedro@nullbug.dev']
  spec.homepage    = ''
  spec.files       = Dir['lib/**/**.rb']
  spec.summary     = 'ZSPAY'
  spec.description = 'ZSPAY'
  spec.license     = 'MIT'

  spec.required_ruby_version = '>= 2.4.0'

  spec.add_runtime_dependency 'http'
  spec.add_development_dependency 'byebug'
  spec.add_development_dependency 'rake'
end
