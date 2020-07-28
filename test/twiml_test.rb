# frozen_string_literal: true

require 'twilio-ruby'
require_relative './test_helper'

class TwimlTest < TestCase
  def test_enter_lobby_response
    digits = '666'

    expected_twiml = Twilio::TwiML::VoiceResponse.new do |response|
      response.play(digits: digits)
    end.to_xml

    assert_equal(expected_twiml, Twiml.enter_lobby_response(digits: digits))
  end
end
