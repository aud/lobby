# frozen_string_literal: true

require 'twilio-ruby'

module TwilioVerification
  class << self
    def verify_twilio_signature(request)
      twilio_signature = request.get_header('HTTP_X_TWILIO_SIGNATURE')

      return false unless twilio_signature
      return false unless validator.validate(
        request.url,
        request.params,
        twilio_signature,
      )

      true
    end

    def validator
      @validator ||= Twilio::Security::RequestValidator.new(
        ENV['TWILIO_AUTH_TOKEN'],
      )
    end
  end
end
