require "rspec"

Dir[File.join(File.dirname(__FILE__), "../", "lib", "*")].each { |file| require(file) }

RSpec.configure do |config|
  config.formatter = :documentation
end
