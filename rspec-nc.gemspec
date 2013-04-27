# -*- encoding: utf-8 -*-
Gem::Specification.new do |gem|
  gem.name          = 'rspec-nc'
  gem.version       = '0.0.6'
  gem.authors       = ['Odin Dutton']
  gem.email         = ['odindutton@gmail.com']
  gem.description   = 'https://github.com/twe4ked/rspec-nc'
  gem.summary       = "RSpec formatter for Mountain Lion's Notification Center"
  gem.homepage      = 'https://github.com/twe4ked/rspec-nc'

  gem.add_dependency 'terminal-notifier', '~> 1.4.2'
  gem.add_dependency 'rspec', '~> 2.9'

  gem.files         = `git ls-files`.split($\)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(spec)/})
  gem.require_paths = ['lib']
end
