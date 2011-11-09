# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "twinfield/version"

Gem::Specification.new do |s|
  s.name        = "twinfield"
  s.version     = Twinfield::VERSION
  s.authors     = ["Ernst Rijsdijk"]
  s.email       = ["ernst.rijsdijk@holder.nl"]
  s.homepage    = "http://www.holder.nl"
  s.summary     = "A simple client for Twinfield SOAP API"
  s.description = "Twinfield is an international Web service for collaborative online accounting. The Ruby twinfield gem is a simple client for their SOAP-based API."

  s.rubyforge_project = "twinfield"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]

  # specify any dependencies here; for example:
  # s.add_development_dependency "rspec"
  # s.add_runtime_dependency "rest-client"
end