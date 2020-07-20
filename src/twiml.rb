# frozen_string_literal: true

require 'twilio-ruby'

module Twiml
  class << self
    def enter_lobby_response
      Twilio::TwiML::VoiceResponse.new do |response|
        response.play(digits: '666')
      end.to_xml
    end
  end
end
