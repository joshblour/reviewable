$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "reviewable/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "reviewable"
  s.version     = Reviewable::VERSION
  s.authors     = ["Yonah forst"]
  s.email       = ["yonaforst@hotmail.com"]
  s.summary     = "review objects"
  s.description = "lets you create reviews for polymorphic objects"
  s.license     = "MIT"

  s.files = Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.rdoc"]
  s.test_files = Dir["spec/**/*"]

  s.add_dependency "rails", ">= 4.0.2"
	s.add_dependency 'simple_form'  
  s.add_dependency "pg"
  
end
