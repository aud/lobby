# frozen_string_literal: true

require_relative './test_helper'

class SendAckMessageTest < TestCase
  def test_send_sms!
    to = '+15555555555'
    from = '+10000000000'

    with_frozen_time do
      TwilioClient.expects(:send_sms!).with(
        to: to,
        from: from,
        body: "Door open request: July 20, 2020 at 08:15:00 pm\n",
      )

      SendAckMessage.send_sms!(
        to: to,
        from: from,
      )
    end
  end

  private

  def with_frozen_time(time = DateTime.parse('July 20th, 2020 at 8:15 PM'))
    unless time.is_a?(DateTime)
      flunk 'Frozen time must be DateTime'
    end

    DateTime.stubs(:now).returns(time)

    yield

    DateTime.unstub(:now)
  end
end
