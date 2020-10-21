require 'test_helper'

class MemberRegistrationMailerTest < ActionMailer::TestCase
  test "send_when_new" do
    mail = MemberRegistrationMailer.send_when_new
    assert_equal "Send when new", mail.subject
    assert_equal ["to@example.org"], mail.to
    assert_equal ["from@example.com"], mail.from
    assert_match "Hi", mail.body.encoded
  end

  test "send_when_update" do
    mail = MemberRegistrationMailer.send_when_update
    assert_equal "Send when update", mail.subject
    assert_equal ["to@example.org"], mail.to
    assert_equal ["from@example.com"], mail.from
    assert_match "Hi", mail.body.encoded
  end

end
