require 'rake/gempackagetask' 
require 'rspec/core/rake_task'

spec = Gem::Specification.new do |s| 
  s.name = "ovfparse"
  s.description = "Uses net/* libraries and nokogiri xml parser to reach out and retrieve .ovf or .ova packages and parse them."
  s.version = "0.10.beta1"
  s.author = ["Jim Barkley", "Kevin Olbrich"]
  s.email = ["jbarkley@mitre.org", "kolbrich@6fusion.com"]
  s.homepage = "http://github.com/ruby-ovf/ovfparse"
  s.platform = Gem::Platform::RUBY
  s.summary = "Retrieves and parses files in the Open Virtualization Format"
  s.files = FileList["{bin,lib}/**/*"].to_a
  s.require_path = "lib"
#  s.autorequire = "name"
  s.test_files = FileList["{test}/**/*test.rb"].to_a
  s.has_rdoc = true
  s.extra_rdoc_files = ["README"]
  s.add_dependency("nokogiri", ">=1.4.1")
end
 
Rake::GemPackageTask.new(spec) do |pkg| 
  pkg.need_tar = true 
end 

desc 'Default: run specs.'
task :default => :spec

desc "Run specs"
RSpec::Core::RakeTask.new do |t|
  t.pattern = "./spec/**/*_spec.rb" # don't need this, it's default.
  # Put spec opts in a file named .rspec in root
end
