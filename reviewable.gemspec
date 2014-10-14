$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "reviewable/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "reviewable"
  s.version     = Reviewable::VERSION
  s.authors     = ["TODO: Your name"]
  s.email       = ["TODO: Your email"]
  s.homepage    = "TODO"
  s.summary     = "TODO: Summary of Reviewable."
  s.description = "TODO: Description of Reviewable."
  s.license     = "MIT"

  s.files = Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.rdoc"]
  s.test_files = Dir["spec/**/*"]

  s.add_dependency "rails", ">= 4.0.2"
	s.add_dependency 'simple_form'  
  s.add_dependency "pg"
  
end
