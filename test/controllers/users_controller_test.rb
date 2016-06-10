require 'test_helper'

class UsersControllerTest < ActionController::TestCase
  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create successfully with valid params" do
    new_user = mock()
    new_user.stubs(:save).returns(true)
    User.stubs(:new).returns(new_user)

    post :create, post_params
    assert_response :success
    assert_equal @response.body, 'success'

    User.unstub(:new)
  end

  test "should create unsuccessfully with invalid params" do
    new_user, errors = mock(), mock()
    new_user.stubs(:save).returns(false)
    new_user.stubs(:errors).returns(errors)
    [:name, :email].each do |attr|
      new_user.stubs(attr).returns('placeholder')
    end
    errors.stubs(:any?).returns(false)
    User.stubs(:new).returns(new_user)

    post :create, post_params
    assert_response :success
    assert_not_equal @response.body, 'success'

    User.unstub(:new)
  end

  private
  
    def post_params
      {
        user: {
          name: 'testname', email: 'testmail',
          password: 'badpasswd',
          password_confirmation: 'badpasswd'
        }
      }
    end
end
