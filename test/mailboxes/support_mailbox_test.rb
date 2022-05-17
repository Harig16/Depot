require "test_helper"

class SupportMailboxTest < ActionMailbox::TestCase
  # test "receive mail" do
  #   receive_inbound_email_from_mail \
  #     to: '"someone" <someone@example.com>',
  #     from: '"else" <else@example.com>',
  #     subject: "Hello world!",
  #     body: "Hello?"
  # end

  test "create SupportRequest when we get email" do
    receive_inbound_email_from_mail(
      to: "support@example.com",
      from: "abc@example.com",
      subject: "Need help",
      body: "I can't figure it out how to checkout"
    )
    support_requests = SupportRequest.last
    assert_equal "abc@example.com", support_requests.email
    assert_equal "Need help", support_requests.subject
    assert_equal "I can't figure it out how to checkout", support_requests.body
    assert_nil support_requests.order
  end

  test "create SupportRequest with recent orders" do

    recent_order = orders(:one)
    old_order = orders(:another_one)
    no_customer_order = orders(:other_customer)

    receive_inbound_email_from_mail(
      to: "support@example.com",
      from: recent_order.email,
      subject: "Need help",
      body: "I can't figure it out how to checkout"
    )
    support_requests = SupportRequest.last
    assert_equal recent_order.email, support_requests.email
    assert_equal "Need help", support_requests.subject
    assert_equal "I can't figure it out how to checkout", support_requests.body
    assert_equal recent_order, support_requests.order
  end
end
