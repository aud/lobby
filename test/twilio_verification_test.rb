# frozen_string_literal: true

require 'test_helper'

require_relative '../src/twilio_verification'

class TwilioVerificationTest < TestCase
  def test_verify_twilio_signature_bails_if_no_signature
    fake_request = stub('fake request')
    fake_request.expects(:get_header).with('HTTP_X_TWILIO_SIGNATURE').returns(nil)

    result = TwilioVerification.verify_twilio_signature(fake_request)

    refute(result)
  end

  def test_verify_twilio_signature_bails_if_validate_fails
    twilio_request_validator_stub.expects(:validate).returns(false)

    result = TwilioVerification.verify_twilio_signature(request_stub)

    refute(result)
  end

  def test_verify_twilio_signature_passes_if_validate_succeeds
    twilio_request_validator_stub.expects(:validate).returns(true)

    result = TwilioVerification.verify_twilio_signature(request_stub)

    assert(result)
  end

  private

  def request_stub
    stub('fake request').tap do |request|
      request.expects(:url).returns('http://example.com')
      request.expects(:params).returns({})
      request.expects(:get_header).with('HTTP_X_TWILIO_SIGNATURE').returns('signature')
    end
  end

  def twilio_request_validator_stub
    stub('fake validator').tap do |validator|
      Twilio::Security::RequestValidator.stubs(:new).returns(validator)
    end
  end
end
