#SimpleCov.start

require 'support/helpers/helpers.rb'

RSpec.configure do |config|
  config.include BoardSetUpHelpers
  config.include GameSetUpHelpers
end