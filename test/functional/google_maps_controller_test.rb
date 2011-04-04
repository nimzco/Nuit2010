require 'test_helper'

class GoogleMapsControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:google_maps)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create google_map" do
    assert_difference('GoogleMap.count') do
      post :create, :google_map => { }
    end

    assert_redirected_to google_map_path(assigns(:google_map))
  end

  test "should show google_map" do
    get :show, :id => google_maps(:one).to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => google_maps(:one).to_param
    assert_response :success
  end

  test "should update google_map" do
    put :update, :id => google_maps(:one).to_param, :google_map => { }
    assert_redirected_to google_map_path(assigns(:google_map))
  end

  test "should destroy google_map" do
    assert_difference('GoogleMap.count', -1) do
      delete :destroy, :id => google_maps(:one).to_param
    end

    assert_redirected_to google_maps_path
  end
end
