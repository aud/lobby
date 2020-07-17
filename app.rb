# frozen_string_literal: true

require 'rack'
require_relative './src/router'

Rack::Handler::WEBrick.run(Router.new, Port: 9001)
