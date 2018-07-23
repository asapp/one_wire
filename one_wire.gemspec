Gem::Specification.new do |spec|
  spec.name = "sysfs_one_wire"
  spec.version = '0.2.0'

  spec.authors = ["as:app worker"]
  spec.summary = %q{asapp_gem}
  spec.description = %q{Maxim's 1-wire binding backed on w1-gpio driver}
  spec.email = %q{opensource@asapp.fr}
  spec.license = "MIT"
  spec.homepage = %q{https://github.com/asapp/one_wire}

  spec.files = `git ls-files`.split($\)
  spec.require_paths = ["lib"]

  spec.extra_rdoc_files = Dir['*.md']
  spec.rdoc_options = ["--charset=UTF-8"]

  spec.add_development_dependency  'rake'
  spec.add_development_dependency  'rspec'
  spec.add_development_dependency  'rdoc'
end
