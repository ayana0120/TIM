require 'test_helper'

class UsersControllerTest < ActionDispatch::IntegrationTest
  test "should get show" do
    get users_show_url
    assert_response :success
  end

  test "should get top" do
    get users_top_url
    assert_response :success
  end

  test "should get about" do
    get users_about_url
    assert_response :success
  end
end
