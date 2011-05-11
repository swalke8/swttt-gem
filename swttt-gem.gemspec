# Generated by jeweler
# DO NOT EDIT THIS FILE DIRECTLY
# Instead, edit Jeweler::Tasks in Rakefile, and run 'rake gemspec'
# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{swttt-gem}
  s.version = "1.0.0"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Stephen Walker"]
  s.date = %q{2011-05-11}
  s.description = %q{TTT Gem}
  s.email = %q{stephenwalker1988@gmail.com}
  s.extra_rdoc_files = [
    "LICENSE.txt",
    "README.rdoc"
  ]
  s.files = [
    ".DS_Store",
    ".document",
    "Gemfile",
    "Gemfile.lock",
    "LICENSE.txt",
    "README.rdoc",
    "Rakefile",
    "VERSION",
    "lib/.DS_Store",
    "lib/board.rb",
    "lib/game_observer.rb",
    "lib/human_player.rb",
    "lib/minimax_computer.rb",
    "lib/swttt-gem.rb",
    "spec/board_spec.rb",
    "spec/game_observer_spec.rb",
    "spec/human_player_spec.rb",
    "spec/minimax_computer_spec.rb",
    "spec/move_spec.rb",
    "spec/spec_helper.rb",
    "swttt-gem.gemspec",
    "test/helper.rb",
    "test/test_swttt-gem.rb"
  ]
  s.homepage = %q{http://github.com/swalke8/swttt-gem}
  s.licenses = ["MIT"]
  s.require_paths = ["lib"]
  s.rubygems_version = %q{1.6.2}
  s.summary = %q{SWTTT Gem}
  s.test_files = [
    "spec/board_spec.rb",
    "spec/game_observer_spec.rb",
    "spec/human_player_spec.rb",
    "spec/minimax_computer_spec.rb",
    "spec/move_spec.rb",
    "spec/spec_helper.rb",
    "test/helper.rb",
    "test/test_swttt-gem.rb"
  ]

  if s.respond_to? :specification_version then
    s.specification_version = 3

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_development_dependency(%q<shoulda>, [">= 0"])
      s.add_development_dependency(%q<bundler>, ["~> 1.0.0"])
      s.add_development_dependency(%q<jeweler>, ["~> 1.5.2"])
      s.add_development_dependency(%q<rcov>, [">= 0"])
    else
      s.add_dependency(%q<shoulda>, [">= 0"])
      s.add_dependency(%q<bundler>, ["~> 1.0.0"])
      s.add_dependency(%q<jeweler>, ["~> 1.5.2"])
      s.add_dependency(%q<rcov>, [">= 0"])
    end
  else
    s.add_dependency(%q<shoulda>, [">= 0"])
    s.add_dependency(%q<bundler>, ["~> 1.0.0"])
    s.add_dependency(%q<jeweler>, ["~> 1.5.2"])
    s.add_dependency(%q<rcov>, [">= 0"])
  end
end

