require 'test_helper'

class PostsControllerTest < ActionController::TestCase
  # test "the truth" do
  #   assert true
  # end
  def setup
    @post, @post2 = posts(:testpost), posts(:testpost2)
    @node = nodes(:testnode)
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
    post :create, post_params
    assert_response :redirect
  end

  test "should create unsuccessfully with invalid params" do
    post_params = {
      :post => {
        :title => "Sample",
        :body => "Sample",
        :node => @node.id
      }
    }
    post :create, post_params
    assert_response :redirect
  end

  test "should show single post" do
    get :show, id: @post.id
    assert_response :success
    assert_template 'posts/show'
    assert_select 'div.post'
  end

  test "should show posts" do
    get :index
    assert_response :success
    assert_template 'posts/index'
    assert_select 'div.posts'
  end

  test "should show the count of comments if there are comments" do
    get :show, id: @post.id
    assert_response :success
    assert_template 'posts/show'
    assert_select 'div.comment-total'
  end

  test "should not show the count of comments if there is no comment" do
    get :show, id: @post2.id
    assert_response :success
    assert_template 'posts/show'
    assert_select 'div.comment-total', false
  end
end
