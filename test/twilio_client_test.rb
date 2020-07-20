# frozen_string_literal: true

require 'test_helper'
require 'twilio-ruby'

require_relative '../src/twilio_client'

class TwilioClientTest < TestCase
  def test_send_sms!
    to = '+15555555555'
    from = '+1111111111'
    body = 'test'

    message_stub = stub('message stub')
    message_stub.expects(:create).with(to: to, from: from, body: body)

    stub_twilio_client.expects(:messages).returns(message_stub)

    TwilioClient.send_sms!(to: to, from: from, body: body)
  end

  private

  def stub_twilio_client
    stub('twilio client stub').tap do |twilio_client|
      Twilio::REST::Client.expects(:new).returns(twilio_client)
    end
  end
end
