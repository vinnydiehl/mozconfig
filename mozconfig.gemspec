# frozen_string_literal: true

Gem::Specification.new do |gem|
  gem.name = "mozconfig"
  gem.version = File.read(File.expand_path("VERSION", __dir__)).strip

  gem.author = "Vinny Diehl"
  gem.email = "vinny.diehl@gmail.com"
  gem.homepage = "https://github.com/vinnydiehl/mozconfig"
  gem.metadata["rubygems_mfa_required"] = "true"

  gem.license = "MIT"

  gem.summary = "TUI mozconfig switcher"
  gem.description = "Switch between mozconfigs quickly and easily."

  gem.bindir = "bin"
  gem.executables = %w[mozconfig]
  gem.files = `git ls-files -z`.split "\x0"

  gem.add_dependency "optimist", "~> 3.1"
  gem.add_dependency "tty-prompt", "~> 0.23"

  gem.add_development_dependency "rubocop", "~> 1.54"
end
