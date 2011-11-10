# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "twinfield/version"

Gem::Specification.new do |s|
  s.name        = "twinfield"
  s.version     = Twinfield::VERSION
  s.authors     = ["Ernst Rijsdijk"]
  s.email       = ["ernst.rijsdijk@holder.nl"]
  s.homepage    = "https://github.com/macernst/twinfield"
  s.summary     = "A simple client for the Twinfield SOAP-based API"
  s.description = "Twinfield is an international Web service for collaborative online accounting. The Twinfield gem is a simple client for their SOAP-based API."

  s.rubyforge_project = "twinfield"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]

  s.add_runtime_dependency "savon"
  s.add_development_dependency 'rspec'
end