# frozen_string_literal: true

lib = File.expand_path("lib", __dir__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "active_record_mask/version"

Gem::Specification.new do |spec|
  spec.name          = "active_record_mask"
  spec.version       = ActiveRecordMask::VERSION
  spec.authors       = ["Sven Tantau"]
  spec.email         = ["sven@beastiebytes.com"]

  spec.summary       = %q{A gem that provides a configurable mechanism to mask read access to Active Record attributes and associations}
  spec.description   = %q{ActiveRecordMask is a small ruby library that provides an easy way to mask read access to database attributes and associations in ActiveRecord objects.}
  spec.homepage      = "https://github.com/sventantau/active_record_mask"
  spec.license       = "MIT"

  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = "https://github.com/sventantau/active_record_mask"
  spec.metadata["bug_tracker_uri"] = "https://github.com/sventantau/active_record_mask/issues"

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.require_paths = ["lib"]

  spec.required_ruby_version = Gem::Requirement.new(">= 2.4.0")

  spec.add_dependency "activerecord"#, ">= 5.2", "<= 7"
  spec.add_dependency "activesupport"#, ">= 5.2", "<= 7"

  spec.add_development_dependency "bundler"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "rspec"
end
