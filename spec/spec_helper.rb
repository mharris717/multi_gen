require 'rubygems'
require 'spork'


Spork.prefork do
  $LOAD_PATH.unshift(File.join(File.dirname(__FILE__), '..', 'lib'))
  $LOAD_PATH.unshift(File.dirname(__FILE__))

  require 'rspec'


  # Requires supporting files with custom matchers and macros, etc,
  # in ./support/ and its subdirectories.
  Dir["#{File.dirname(__FILE__)}/support/**/*.rb"].each {|f| require f}

  RSpec.configure do |config|
    #config.filter_run :focus => true
    config.fail_fast = false
  end
end

Spork.each_run do
  load File.dirname(__FILE__) + "/../lib/multi_gen.rb"
  #Dir["#{File.dirname(__FILE__)}/support/**/*.rb"].each {|f| load f}
end
