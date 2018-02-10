require 'test_helper'

class AppliedControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get applied_index_url
    assert_response :success
  end

end
