# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "pomodoro/version"

Gem::Specification.new do |s|
  s.name        = "pomodoro"
  s.version     = Pomodoro::VERSION
  s.platform    = Gem::Platform::RUBY
  s.authors     = ["Steve Klabnik"]
  s.email       = ["steve@steveklabnik.com"]
  s.homepage    = "http://github.com/steveklabnik/pomodoro"
  s.summary     = %q{Turns off certain sites in conjunction with pomodoro timekeeping.}
  s.description = %q{I can never get work done because the internet makes it too easy to waste time. This turns off access to sites, but lets you on every so often, too.}

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]

  s.add_dependency("noprocrast")
  s.add_dependency("thin")
  s.add_dependency("sinatra")
	s.add_dependency("terminal-notifier")
end
