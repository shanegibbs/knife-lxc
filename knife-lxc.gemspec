# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "knife-lxc/version"

Gem::Specification.new do |s|
  s.name        = "knife-lxc"
  s.version     = KnifeLxc::VERSION
  s.authors     = ["Lukasz Kaniowski"]
  s.email       = ["developers@creatary.com"]
  s.homepage    = "https://github.com/creatary/knife-lxc"
  s.summary     = "Lxc plugin for knife."
  s.description = "Handles creation and deletion of lxc containers."

  s.rubyforge_project = "knife-lxc"


  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]

  # specify any dependencies here; for example:
  # s.add_development_dependency "rspec"
  # s.add_runtime_dependency "rest-client"

  s.add_dependency 'chef',    '~> 11'
  s.add_dependency 'toft'

  s.add_development_dependency 'cucumber-chef'
end
