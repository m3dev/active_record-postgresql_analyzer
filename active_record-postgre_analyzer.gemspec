# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'active_record/postgre_analyzer/version'

Gem::Specification.new do |spec|
  spec.name          = "active_record-postgre_analyzer"
  spec.version       = ActiveRecord::PostgreAnalyzer::VERSION
  spec.authors       = ["Takayuki Matsubara"]
  spec.email         = ["takayuki.1229@gmail.com"]

  spec.summary       = %q{Analyze the execution plan and write log if sequential scan is detected}
  spec.description   = %q{Analyze the execution plan and write log if sequential scan is detected}
  spec.homepage      = "https://github.com/m3dev/active_record-postgre_analyzer"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_runtime_dependency "activerecord", ">= 4.2"

  spec.add_development_dependency "bundler", ">= 1.9"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec"
  spec.add_development_dependency "pg"
end
