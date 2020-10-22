require 'test_helper'

class NotificationMailerTest < ActionMailer::TestCase
  test "warning" do
    mail = NotificationMailer.warning
    assert_equal "Warning", mail.subject
    assert_equal ["to@example.org"], mail.to
    assert_equal ["from@example.com"], mail.from
    assert_match "Hi", mail.body.encoded
  end

  test "expired" do
    mail = NotificationMailer.expired
    assert_equal "Expired", mail.subject
    assert_equal ["to@example.org"], mail.to
    assert_equal ["from@example.com"], mail.from
    assert_match "Hi", mail.body.encoded
  end

end
