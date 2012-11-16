# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "gg/version"

Gem::Specification.new do |s|
  s.name        = "gg"
  s.version     = GG::VERSION
  s.authors     = ["Sunny Hirai"]
  s.email       = ["thesunny@gmail.com"]
  s.homepage    = ""
  s.summary     = %q{Log to the Browser}
  s.description = %q{Log to the Browser}

  s.rubyforge_project = "gg"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]

  # specify any dependencies here; for example:
  # s.add_development_dependency "rspec"
  # s.add_runtime_dependency "rest-client"
  s.add_development_dependency 'rake'
  s.add_dependency 'awesome_print'
  s.add_dependency 'rack'
  s.add_dependency 'slim'
  s.add_dependency 'hi_caller'
end
