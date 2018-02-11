require 'test_helper'

class RemorseappControllerTest < ActionDispatch::IntegrationTest
  test "should get show" do
    get remorseapp_show_url
    assert_response :success
  end

end
