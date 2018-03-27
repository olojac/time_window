lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "time_window/version"

Gem::Specification.new do |spec|
  spec.name          = "slide"
  spec.version       = TimeWindow::VERSION
  spec.authors       = ["Olov Jacobsen"]
  spec.email         = ["olle@ojacobsen.se"]

  spec.summary       = "slide..."
  spec.description   = "slide..."
  spec.homepage      = "https://github.com/olojac/"
  spec.license       = "MIT"

  spec.files         = Dir["lib/**/*.rb"] + Dir["bin/*"]
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_dependency "activesupport", ">= 4.2"

  spec.add_development_dependency "bundler"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "rspec"
  spec.add_development_dependency "pry"
  spec.add_development_dependency "pry-rescue"
  spec.add_development_dependency "benchmark-ips"
  spec.add_development_dependency "simplecov"
end
