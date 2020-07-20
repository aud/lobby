# frozen_string_literal: true

require_relative './twilio_verification'
require_relative './send_ack_message'
require_relative './twiml'

class Router
  def call(env)
    request = Rack::Request.new(env)

    route(request)
  end

  private

  TWILIO_WEBHOOKS_PATH = '/webhooks/open_door'
  private_constant(:TWILIO_WEBHOOKS_PATH)

  def route(request)
    case request.path_info
    when TWILIO_WEBHOOKS_PATH
      if TwilioVerification.verify_twilio_signature(request)
        SendAckMessage.send_sms!(
          to: ENV['TO_NUMBER'],
          from: ENV['FROM_NUMBER'],
        )

        return [200, {'Content-Type' => 'application/xml'}, [Twiml.enter_lobby_response(digits: ENV['RESPONSE_DIGITS']]]
      else
        return [403, {'Content-Type' => 'text/html'}, []]
      end
    else
      return [404, {'Content-Type' => 'text/html'}, []]
    end
  end
end
