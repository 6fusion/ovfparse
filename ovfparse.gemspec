# -*- encoding: utf-8 -*-
require File.expand_path('../lib/ovfparse/version', __FILE__)

Gem::Specification.new do |gem|
  gem.authors     = ["Kevin Olbrich", "Jim Barkley"]
  gem.email       = ["kolbrich@6fusion.com", 'jbarkley@mitre.org']
  gem.description = %q{Uses net/* libraries and nokogiri xml parser to reach out and retrieve .ovf or .ova packages and parse them.}
  gem.summary     = %q{Retrieves and parses files in the Open Virtualization Format}
  gem.homepage    = "http://github.com/6fusion/ovfparse"

  gem.files         = `git ls-files`.split($\)
  gem.executables   = gem.files.grep(%r{^bin/}).map { |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.name          = "ovfparse"
  gem.require_paths = ["lib"]
  gem.version       = Ovfparse::VERSION
  gem.add_dependency('nokogiri', '>=1.4.1')
end
