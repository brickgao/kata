require 'test_helper'

class PostsControllerTest < ActionController::TestCase
  # test "the truth" do
  #   assert true
  # end
  def setup
    session[:user_id] = users(:alice).id
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create successfully with valid params" do
    post_params = {
      :post => {
        :title => "Sample Title",
        :body => "Sample Body",
        :node => nodes(:testnode)
      }
    }
    new_post = mock()
    new_post.stubs(:save).returns(true)
    Post.stubs(:new).returns(new_post)

    post :create, post_params
    assert_response :success
    assert_equal @response.body, 'success'

    Post.unstub(:new)
  end

  test "should create unsuccessfully with invalid params" do
    post_params = {
      :post => {
        :title => "Sample",
        :body => "Sample",
        :node => nodes(:testnode)
      }
    }
    post :create, post_params
    assert_response :success
    assert_template 'posts/new'
    assert_select 'div.error-message'
  end
end
