require 'test_helper'

class MessagesControllerTest < ActionController::TestCase
  # test "the truth" do
  #   assert true
  # end
  def setup
    @from, @to = users(:alice), users(:bob)
    session[:user_id] = @from.id
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

  test "should get chat successful" do
    get :show_chat, {:chat_with_id => @to.id }
    assert_response :success
    assert_template 'messages/show_chat'
    assert_select '.chat'
  end

  test "should get chat unsuccessfully with invalid chat_with_id" do
    get :show_chat, {:chat_with_id => 233333 }
    assert_response :redirect
  end

  test "should get the count of unread messages" do
    get :get_unread_messages_count
    assert_response :success
    result = JSON.parse(@response.body)
    assert_equal result['unread_messages_count'], 1
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
