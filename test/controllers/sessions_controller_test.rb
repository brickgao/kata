require 'test_helper'

class SessionsControllerTest < ActionController::TestCase

  def setup
    @user = users(:alice)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "login with valid information" do
    post :create, session: { email: @user.email, password: 'badpassword' }
    assert_redirected_to '/'
  end

  test "login with invalid information" do
    post :create, session: { email: @user.email, password: 'invalid' }
    assert_template 'new'
    assert_select 'div.error-message'
  end
end
