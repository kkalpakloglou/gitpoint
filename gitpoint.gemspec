
lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "gitpoint/version"

Gem::Specification.new do |spec|
  spec.name          = "gitpoint"
  spec.version       = Gitpoint::VERSION
  spec.platform      = Gem::Platform::RUBY
  spec.authors       = ["Konstantinos Kalpakloglou"]
  spec.email         = ["kkalpakloglou@yahoo.com"]

  spec.summary       = %q{A Simple command line app to search git repos and fetch language stats.}
  spec.description   = %q{A Simple command line app to search git repos and fetch language statistics.}
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.bindir        = "bin"
  spec.executables   = ['gitpoint']
 
  spec.add_development_dependency "bundler", "~> 1.16"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_runtime_dependency 'thor', '~> 0.19.1'
  spec.add_runtime_dependency 'rainbow', '~> 3.0'
  spec.add_runtime_dependency 'github_api', '~> 0.18.2'
  spec.add_runtime_dependency "activesupport"
end
