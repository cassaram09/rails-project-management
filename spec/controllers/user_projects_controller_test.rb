require 'test_helper'

class UserProjectsControllerTest < ActionController::TestCase
  test "should get edit_user_project_permission" do
    get :edit_user_project_permission
    assert_response :success
  end

end
