require 'test_helper'

class Front::MessageControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
  end

end
