$LOAD_PATH.push File.expand_path('../lib', __FILE__)

# Maintain your gem's version:
require 'foreman_ovm/version'
require 'date'

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = 'foreman_ovm'
  s.version     = ForemanOvm::VERSION
  s.date        = Date.today.to_s
  s.authors     = ['Matthew Wilmott']
  s.email       = ['mattwilmott@gmail.com']
  s.homepage    = 'http://github.com/mattwilmott/foreman-ovm'
  s.summary     = 'Provision and manage Oracle Virtual Machines from Foreman'
  s.description = 'Provision and manage Oracle Virtual Machines from Foreman.'
  s.licenses    = ['GPL-3']

  s.files = Dir['{app,config,db,lib,locale}/**/*', 'LICENSE', 'Rakefile', 'README.md']
  s.test_files = Dir['test/**/*']

  s.add_development_dependency 'rubocop', '~> 0.42'
end
