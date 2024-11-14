# account-item-master-ruby-client.gemspec
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'account_item_master/version'

Gem::Specification.new do |spec|
  spec.name          = "account-item-master-ruby-client"
  spec.version       = AccountItemMaster::VERSION
  spec.authors       = ["Thong Le Phi"]
  spec.email         = ["lpthong90@gmail.com"]
  spec.summary       = %q{Ruby client for Account Item Master Service}
  spec.description   = %q{A Ruby gRPC client for interacting with the Account Item Master Service}
  spec.homepage      = "https://github.com/lpthong90/account-item-master-ruby-client"
  spec.license       = "MIT"

  spec.files         = Dir["{lib,protos}/**/*", "README.md"]
  spec.require_paths = ["lib"]

  spec.add_dependency "grpc", "~> 1.50"
  spec.add_development_dependency "bundler", "~> 2.0"
  spec.add_development_dependency "rake", "~> 13.0"
end
