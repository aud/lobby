# frozen_string_literal: true

require 'twilio-ruby'
require_relative './twilio_client'

class SendAckMessage
  class << self
    def send_sms!(to:, from:)
      TwilioClient.send_sms!(
        to: to,
        from: from,
        body: message,
      )
    end

    private

    def message
      <<~MESSAGE
        Door open request: #{normalized_time}
      MESSAGE
    end

    def normalized_time
      DateTime.now.strftime("%B %d, %Y at %I:%M:%S %P")
    end
  end
end
