# frozen_string_literal: true

require_relative "lib/zkt_client/version"

Gem::Specification.new do |spec|
  spec.name = "zkt_client"
  spec.version = ZktClient::VERSION
  spec.authors = ["Ahmed Baqtyan"]
  spec.email = ["baqtyan.as@gmail.com"]
  spec.summary = "Ruby API Client for Zkt platform it will help you to make an easy integration with Zkt APIs."
  spec.homepage = "https://github.com/Ahmed-Salem-Baqtyan/zkt_client"
  spec.license = "MIT"
  spec.required_ruby_version = ">= 3.3.3"

  spec.metadata["allowed_push_host"] = "https://rubygems.org"

  spec.metadata["homepage_uri"]    = spec.homepage
  spec.metadata["source_code_uri"] = spec.homepage
  spec.metadata["changelog_uri"] = "https://github.com/Ahmed-Salem-Baqtyan/zkt_client/blob/main/CHANGELOG.md"
  spec.metadata["rubygems_mfa_required"] = "true"

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  gemspec = File.basename(__FILE__)
  spec.files = IO.popen(%w[git ls-files -z], chdir: __dir__, err: IO::NULL) do |ls|
    ls.readlines("\x0", chomp: true).reject do |f|
      (f == gemspec) ||
        f.start_with?(*%w[bin/ test/ spec/ features/ .git .github appveyor Gemfile])
    end
  end
  spec.bindir = "exe"
  spec.executables = spec.files.grep(%r{\Aexe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  # Uncomment to register a new dependency of your gem
  # spec.add_dependency "example-gem", "~> 1.0"

  # For more information and examples about making a new gem, check out our
  # guide at: https://bundler.io/guides/creating_gem.html

  spec.add_dependency "bundler", "~> 2.5", ">= 2.5.14"
  spec.add_dependency "faraday", "~> 2.12"
  spec.add_dependency "rake", "~> 13.2", ">= 13.2.1"

  spec.add_development_dependency "byebug", "~> 11.1", ">= 11.1.3"
  spec.add_development_dependency "rspec", "~> 3.13"
  spec.add_development_dependency "rubocop", "~> 1.66", ">= 1.66.1"
  spec.add_development_dependency "vcr", "~> 6.3", ">= 6.3.1"
end
