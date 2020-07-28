# frozen_string_literal: true

require 'minitest/autorun'
require 'mocha/minitest'

Dir.glob('./src/**/*.rb').each do |file|
  require file
end

TestCase = Class.new(Minitest::Test)
