# frozen_string_literal: true

require 'twilio-ruby'

module TwilioClient
  class << self
    def send_sms!(from:, to:, body:)
      client.messages.create(to: to, from: from, body: body)
    end

    private

    def client
      @client ||= Twilio::REST::Client.new(
        ENV['TWILIO_ACCOUNT_SID'],
        ENV['TWILIO_AUTH_TOKEN'],
      )
    end
  end
end
