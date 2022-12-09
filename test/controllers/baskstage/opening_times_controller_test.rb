require "test_helper"

class Baskstage::OpeningTimesControllerTest < ActionDispatch::IntegrationTest
  test "should get show" do
    get baskstage_opening_times_show_url
    assert_response :success
  end

  test "should get edit" do
    get baskstage_opening_times_edit_url
    assert_response :success
  end
end
