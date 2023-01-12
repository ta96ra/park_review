require "test_helper"

class Admin::ParksControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get admin_parks_index_url
    assert_response :success
  end

  test "should get show" do
    get admin_parks_show_url
    assert_response :success
  end

  test "should get edit" do
    get admin_parks_edit_url
    assert_response :success
  end
end
