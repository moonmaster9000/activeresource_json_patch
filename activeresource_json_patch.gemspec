Gem::Specification.new do |s|
  s.name = %q{yasm}
  s.version = File.read "VERSION"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Matt Parker"]
  s.date = %q{2011-04-24}
  s.summary = %q{JSON fix for ActiveResource (Rails 3).}
  s.description = %q{Fixes json formatting problem with ActiveResource.}
  s.email = %q{moonmaster9000@gmail.com}
  s.extra_rdoc_files = [
    "readme.md"
  ]
  
  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
 
  s.homepage = %q{http://github.com/moonmaster9000/activeresource_json_patch}
  s.require_paths = ["lib"]
  s.rubygems_version = %q{1.5.0}
  
  s.add_dependency(%q<activeresource>, ["~> 3.0"])
  s.add_development_dependency(%q<cucumber>, ["~> 0.10.0"])
  s.add_development_dependency(%q<rspec>, ["~> 2.4.0"])
end
