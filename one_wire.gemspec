Gem::Specification.new do |s|
  s.name = "one_wire"
  s.version = '0.0.1'

  s.authors = ["as:app worker"]
  s.description = %q{Maxim's Integrated One wire binding}
  s.summary = %q{asapp_gem}

  s.email = %q{opensource@asapp.fr}
  s.license = "MIT"
  s.extra_rdoc_files = Dir['*.md']
  s.files = `git ls-files`.split($\)
  s.homepage = %q{https://github.com/asapp}
  s.rdoc_options = ["--charset=UTF-8"]
  s.require_paths = ["lib"]

  s.add_development_dependency  'rake'
  s.add_development_dependency  'rspec'
  s.add_development_dependency  'rdoc'
end
