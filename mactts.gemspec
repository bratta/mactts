# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{mactts}
  s.version = "0.1.1"

  s.required_rubygems_version = Gem::Requirement.new(">= 1.2") if s.respond_to? :required_rubygems_version=
  s.authors = ["Tim Gourley"]
  s.date = %q{2009-06-21}
  s.description = %q{Ruby wrapper around the Mac OS X say command}
  s.email = %q{tgourley@gmail.com}
  s.extra_rdoc_files = ["CHANGELOG", "lib/mactts.rb", "LICENSE", "README.rdoc", "tasks/rspec.rake"]
  s.files = ["CHANGELOG", "lib/mactts.rb", "LICENSE", "mactts.gemspec", "Manifest", "Rakefile", "README.rdoc", "spec/mactts_spec.rb", "spec/spec_helper.rb", "tasks/rspec.rake"]
  s.has_rdoc = true
  s.homepage = %q{http://github.com/bratta/mactts}
  s.rdoc_options = ["--line-numbers", "--inline-source", "--title", "Mactts", "--main", "README.rdoc"]
  s.require_paths = ["lib"]
  s.rubyforge_project = %q{mactts}
  s.rubygems_version = %q{1.3.1}
  s.summary = %q{Ruby wrapper around the Mac OS X say command}

  if s.respond_to? :specification_version then
    current_version = Gem::Specification::CURRENT_SPECIFICATION_VERSION
    s.specification_version = 2

    if Gem::Version.new(Gem::RubyGemsVersion) >= Gem::Version.new('1.2.0') then
    else
    end
  else
  end
end
