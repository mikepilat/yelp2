# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "yelp2/version"

Gem::Specification.new do |s|
  s.name        = "yelp2"
  s.version     = Yelp2::VERSION
  s.platform    = Gem::Platform::RUBY
  s.authors     = ["Michael Pilat"]
  s.email       = ["mike@mikepilat.com"]
  s.homepage    = ""
  s.summary     = %q{A simple wrapper around the Yelp v2 API}
  s.description = %q{A simple wrapper around the Yelp v2 API}

  s.rubyforge_project = "yelp2"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]
  
  s.add_dependency('oauth', '>= 0.4.4')
  s.add_dependency('addressable', '>= 2.2.6')
  s.add_dependency('json', '>= 1.5.1')

  s.add_development_dependency('rspec', '>= 2.7.0')
  s.add_development_dependency('vcr', '>= 1.11.3')
  s.add_development_dependency('fakeweb', '>= 1.3.0')
end
