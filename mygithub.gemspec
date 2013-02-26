# -*- encoding: utf-8 -*-
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'mygithub/version'

Gem::Specification.new do |gem|
  gem.name          = "mygithub"
  gem.version       = Mygithub::VERSION
  gem.authors       = ["ongaeshi"]
  gem.email         = ["ongaeshi0621@gmail.com"]
  gem.description   = %q{Fast search in offline Github source code of its own.}
  gem.summary       = %q{Fast search in offline Github source code of its own.}
  gem.homepage      = ""

  gem.files         = `git ls-files`.split($/)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.require_paths = ["lib"]

  gem.add_dependency 'thor', '~> 0.15.0'
  gem.add_dependency 'rack', '~> 1.4.0'
  gem.add_dependency 'milkode', '>= 0.9.8'
  gem.add_dependency 'github_api'
  gem.add_dependency 'omniauth'
  gem.add_dependency 'omniauth-github'
end
