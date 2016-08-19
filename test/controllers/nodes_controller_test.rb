require 'json'
require 'test_helper'

class NodesControllerTest < ActionController::TestCase
  # test "the truth" do
  #   assert true
  # end

  def setup
    user = users(:alice)
    session[:user_id] = user.id
  end

  test "should return nodes" do
    get :index
    assert_response :success
    data = Node.all.map { |node| { :id => node.id, :name => node.name } }
    assert_equal @response.body, JSON.dump(data)
  end

  test "should get new successfully" do
    get :new
    assert_response :success
  end
  
  test "should create node successfully" do
    post :create, post_params
    assert_response :redirect
  end

  test "should create node unsuccessfully with empty name" do
    _post_params = post_params
    _post_params[:node][:name] = ''
    post :create, _post_params
    assert_response :success
    assert_select 'div.error-message'
  end

  private
    def post_params
      {
        :node => {
            :name => 'samplename',
            :summary => 'samplesummary'
        }
      }
    end
end
