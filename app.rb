# frozen_string_literal: true

require 'rack'
require 'twilio-ruby'
require 'pry-byebug'

require_relative './twilio_verification'
require_relative './send_ack_message'

class App
  TWILIO_WEBHOOKS_PATH = '/webhooks/open_door'
  private_constant(:TWILIO_WEBHOOKS_PATH)

  def call(env)
    request = Rack::Request.new(env)

    case request.path_info
    when TWILIO_WEBHOOKS_PATH
      if TwilioVerification.verify_twilio_signature(request)
        SendAckMessage.send_sms!

        return [200, {'Content-Type' => 'application/xml'}, [twiml]]
      else
        return [403, {'Content-Type' => 'text/html'}, []]
      end
    else
      return [404, {'Content-Type' => 'text/html'}, []]
    end
  end

  private

  def twiml
    Twilio::TwiML::VoiceResponse.new do |response|
      response.play(digits: '666')
    end.to_s
  end
end

Rack::Handler::WEBrick.run(App.new, Port: 9001)
