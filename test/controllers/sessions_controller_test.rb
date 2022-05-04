require 'test_helper'

class SessionsControllerTest < ActionDispatch::IntegrationTest
  setup do 
    @user = users(:one)
  end

  test "should get login page" do
    get login_url
    assert_response :success
  end

  test "get login using user name and password" do
    post login_url, params: { name: @user.name, password: "secret" }
    assert_redirected_to admin_url
    assert_equal "User logged in successfully!", flash[:alert]
    assert_equal @user.id, session[:user_id]
  end

  test "should get destroy" do
    delete logout_url
    assert_redirected_to store_index_url
    assert_equal "User logout successfully", flash[:alert]
  end

end
