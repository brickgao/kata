require 'test_helper'

class UsersControllerTest < ActionController::TestCase

  def setup
    @user = users(:alice)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create successfully with valid params" do
    post_params = {
      :user => {
        :name => 'testname', :email => 'testmail',
        :password => 'badpassword',
        :password_confirmation => 'badpassword'
      }
    }
    new_user = mock()
    new_user.stubs(:save).returns(true)
    User.stubs(:new).returns(new_user)

    post :create, post_params
    assert_response :success
    assert_equal @response.body, 'success'

    User.unstub(:new)
  end

  test "should create unsuccessfully with invalid params" do
    post_params = {
      :user => {
        :name => 'testname', :email => 'testmail',
        :password => 'badpassword',
        :password_confirmation => 'yetanotherbadpassword'
      }
    }
    post :create, post_params
    assert_response :success
    assert_template 'users/new'
    assert_select 'div.error-message'
  end

  test "should get show" do
    session[:user_id] = @user.id
    get :show, :id => @user.id
    assert_response :success
    assert_select 'div.profile'
  end
end
