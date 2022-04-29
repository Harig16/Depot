require "application_system_test_case"

class OrdersTest < ApplicationSystemTestCase

  # test active jobs in system test
  include ActiveJob::TestHelper

  setup do
    @order = orders(:one)
  end

  test "visiting the index" do
    visit orders_url
    assert_selector "h1", text: "Orders"
  end

  test "creating a Order" do
    visit store_index_url
    click_on "Add to Cart", match: :first

    click_on "Check Out"
    #visit orders_url
    #click_on "New Order"

    fill_in "Address", with: @order.address
    fill_in "Email", with: @order.email
    fill_in "Name", with: @order.name
    select @order.pay_type, from: "Paytype"
    click_on "Place Order"

    assert_text "Thank you for your order"
  end

  test "updating a Order" do
    visit orders_url
    click_on "Edit", match: :first

    fill_in "order_address", with: @order.address
    fill_in "order_email", with: @order.email
    fill_in "order_name", with: @order.name
    #fill_in "Paytype", with: @order.pay_type
    click_on "Place Order"

    assert_text "Order was successfully updated."
    click_on "Back"
  end

  test "destroying a Order" do
    visit orders_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Order was successfully destroyed"
  end

  test "routing number" do
    visit store_index_url

    click_on "Add to Cart", match: :first

    click_on "Check Out"

    fill_in "order_name", with: "Test user"
    fill_in "order_address", with: "test user address"
    fill_in "order_email", with: "test.user@email.com"
    
    assert_no_selector "#order_routing_number"
    select "Check", from: "Paytype"
    assert_selector "#order_routing_number"
  end

  test "credit card number" do
    visit store_index_url

    click_on "Add to Cart", match: :first

    click_on "Check Out"

    fill_in "order_name", with: "Test user"
    fill_in "order_address", with: "test user address"
    fill_in "order_email", with: "test.user@email.com"
    
    assert_no_selector "#order_credit_card"
    select "Credit Card", from: "Paytype"
    assert_selector "#order_credit_card"
  end

  test "purchase order number" do
    visit store_index_url

    click_on "Add to Cart", match: :first

    click_on "Check Out"

    fill_in "order_name", with: "Test user"
    fill_in "order_address", with: "test user address"
    fill_in "order_email", with: "test.user@email.com"
    
    assert_no_selector "#order_po_number"
    select "Purchase Order", from: "Paytype"
    assert_selector "#order_po_number"
  end

  test "check routing number" do
    LineItem.delete_all
    Order.delete_all 

    visit store_index_url

    click_on "Add to Cart", match: :first

    click_on "Check Out"

    fill_in "order_name", with: "Test user"
    fill_in "order_address", with: "test user address"
    fill_in "order_email", with: "test.user@email.com"

    select "Check", from: "Paytype"
    assert_selector "#order_routing_number"
    fill_in "order_routing_number", with: "123456"
    fill_in "order_account_number", with: "987654321"

    perform_enqueued_jobs do 
      click_button "Place Order"
    end

    orders = Order.all

    assert_equal 1, orders.size

    order = Order.first

    assert_equal "Test user", order.name
    assert_equal "test user address", order.address
    assert_equal "test.user@email.com", order.email
    assert_equal "Check", order.pay_type
    assert_equal 1, order.line_items.size

    mail = ActionMailer::Base.deliveries.last
    assert_equal "test.user@email.com", mail[:to].value
    assert_equal "Depot Application <depot.application@apps.com>", mail[:from].value
    assert_equal "Pragmatic Store Order Confirmation", mail.subject
  end
end
