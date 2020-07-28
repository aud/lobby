# frozen_string_literal: true

require 'rack'

require_relative './test_helper'

class RouterTest < TestCase
  def test_200
    Kernel.expects(:sleep).with(2.0)

    TwilioVerification
      .expects(:verify_twilio_signature)
      .returns(true)

    SendAckMessage.expects(:send_sms!)
    Twiml.expects(:enter_lobby_response).returns('some xml')

    fake_env = {
      'PATH_INFO' => '/webhooks/open_door'
    }

    result = Router.new.call(fake_env)
    expected_result = [200, {'Content-Type' => 'application/xml'}, ['some xml']]

    assert_equal(expected_result, result)
  end

  def test_403
    TwilioVerification
      .expects(:verify_twilio_signature)
      .returns(false)

    fake_env = {
      'PATH_INFO' => '/webhooks/open_door'
    }

    result = Router.new.call(fake_env)
    expected_result = [403, {'Content-Type' => 'text/plain'}, []]

    assert_equal(expected_result, result)
  end

  def test_404
    fake_env = {
      'PATH_INFO' => 'invalid path'
    }

    result = Router.new.call(fake_env)
    expected_result = [404, {'Content-Type' => 'text/plain'}, []]

    assert_equal(expected_result, result)
  end
end
