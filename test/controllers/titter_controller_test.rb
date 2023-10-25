require "test_helper"

class TitterControllerTest < ActionDispatch::IntegrationTest
  test "should get top" do
    get titter_top_url
    assert_response :success
  end
end
