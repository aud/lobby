# frozen_string_literal: true

require 'test_helper'
require 'twilio-ruby'

require_relative '../src/twiml'

class TwimlTest < TestCase
  def test_enter_lobby_response
    expected_twiml = Twilio::TwiML::VoiceResponse.new do |response|
      response.play(digits: '666')
    end.to_xml

    assert_equal(expected_twiml, Twiml.enter_lobby_response)
  end
end
