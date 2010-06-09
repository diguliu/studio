require 'test_helper'

class BandsControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:bands)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create band" do
    assert_difference('Band.count') do
      post :create, :band => { }
    end

    assert_redirected_to band_path(assigns(:band))
  end

  test "should show band" do
    get :show, :id => bands(:one).id
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => bands(:one).id
    assert_response :success
  end

  test "should update band" do
    put :update, :id => bands(:one).id, :band => { }
    assert_redirected_to band_path(assigns(:band))
  end

  test "should destroy band" do
    assert_difference('Band.count', -1) do
      delete :destroy, :id => bands(:one).id
    end

    assert_redirected_to bands_path
  end
end
