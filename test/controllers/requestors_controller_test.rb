require "test_helper"

class RequestorsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get requestors_index_url
    assert_response :success
  end

  test "should get new" do
    get requestors_new_url
    assert_response :success
  end
end
