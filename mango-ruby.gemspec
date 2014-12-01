# encoding: utf-8

Gem::Specification.new do |s|
  s.name              = "mango-ruby"
  s.version           = "0.0.1"
  s.summary           = "Ruby wrapper for Mango API"
  s.description       = "API to interact with Mango\nhttps://getmango.com/"
  s.authors           = ["Joaquín Vicente"]
  s.email             = ["joakin@gmail.com"]
  s.homepage          = "https://getmango.com/"
  s.files             = []

  s.license           = "MIT"
  s.executables.push("mango")
  s.add_dependency('rest-client', '~> 1.7')
  s.add_development_dependency('cutest', '~> 1.2')
  s.add_development_dependency('mocha', '~> 1.1')

  s.files = %w{
    bin/mango
    lib/mango.rb
    lib/mango-ruby.rb
    lib/mango/resources.rb
    lib/mango/operations.rb
  }

  s.test_files = %w{
    test/mango_test.rb
    test/test_helper.rb
  }

end
