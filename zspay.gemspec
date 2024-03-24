# frozen_string_literal: true

# Maintain your gem's version:
require_relative "lib/zspay/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |spec|
  spec.name        = "zspay"
  spec.version     = Zspay::VERSION
  spec.authors     = ["Pedro Augusto Silva", "Edson Lima", "Nullbug"]
  spec.email       = %w[pedro@nullbug.dev edson@nullbug.dev]
  spec.homepage    = "https://github.com/pedroaugustofsilva/zspay-ruby"
  spec.summary     = "Ruby interface for Zspay API."
  spec.description = "A Ruby interface for integrating and managing payment and transfer functionalities with the " \
                     "Zspay platform."
  spec.license     = "MIT"

  spec.required_ruby_version = Gem::Requirement.new("~> 3.0")

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files = Dir.chdir(__dir__) do
    `git ls-files -z`.split("\x0").reject do |f|
      (File.expand_path(f) == __FILE__) ||
        f.start_with?(*%w[bin/ test/ spec/ features/ .git .github appveyor Gemfile])
    end
  end
  spec.bindir = "exe"
  spec.executables = spec.files.grep(%r{\Aexe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_runtime_dependency "activesupport", ">= 6.0.0"
  spec.add_runtime_dependency "http", ">= 5.2.0"

  spec.metadata["rubygems_mfa_required"] = "true"
end
