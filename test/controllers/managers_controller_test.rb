require "test_helper"

class ManagersControllerTest < ActionDispatch::IntegrationTest
  test "should get show" do
    get managers_show_url
    assert_response :success
  end
end
