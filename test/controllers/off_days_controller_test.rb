require "test_helper"

class OffDaysControllerTest < ActionDispatch::IntegrationTest
  test "should get edit" do
    get off_days_edit_url
    assert_response :success
  end
end
