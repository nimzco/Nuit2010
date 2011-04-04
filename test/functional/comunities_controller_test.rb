require 'test_helper'

class ComunitiesControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:comunities)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create comunity" do
    assert_difference('Comunity.count') do
      post :create, :comunity => { }
    end

    assert_redirected_to comunity_path(assigns(:comunity))
  end

  test "should show comunity" do
    get :show, :id => comunities(:one).to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => comunities(:one).to_param
    assert_response :success
  end

  test "should update comunity" do
    put :update, :id => comunities(:one).to_param, :comunity => { }
    assert_redirected_to comunity_path(assigns(:comunity))
  end

  test "should destroy comunity" do
    assert_difference('Comunity.count', -1) do
      delete :destroy, :id => comunities(:one).to_param
    end

    assert_redirected_to comunities_path
  end
end
