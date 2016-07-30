require 'test_helper'

class MessagesControllerTest < ActionController::TestCase
  # test "the truth" do
  #   assert true
  # end
  def setup
    @from, @to = users(:alice), users(:bob)
    session[:user_id] = @from.id
  end

  test "should get new" do
    get :new, { :to_id => @to.id }
    assert_response :success
  end

  test "should get unsuccessfully without to_id" do
    get :new
    assert_response :redirect
  end

  test "should get unsuccessfully with invalid to_id" do
    get :new, { :to_id => 233333 }
    assert_response :redirect
  end

  test "should create successfully with valid params" do
    post :create, message_params
    assert_response :redirect
  end

  private
    def message_params
      {
        :message => {
          :to_id => @to.id,
          :body => "test message",
          :is_read => false
        }
      }
    end
end
