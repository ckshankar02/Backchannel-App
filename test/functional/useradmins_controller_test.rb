require 'test_helper'

class UseradminsControllerTest < ActionController::TestCase
  setup do
    @useradmin = useradmins(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:useradmins)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create useradmin" do
    assert_difference('Useradmin.count') do
      post :create, useradmin: @useradmin.attributes
    end

    assert_redirected_to useradmin_path(assigns(:useradmin))
  end

  test "should show useradmin" do
    get :show, id: @useradmin
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @useradmin
    assert_response :success
  end

  test "should update useradmin" do
    put :update, id: @useradmin, useradmin: @useradmin.attributes
    assert_redirected_to useradmin_path(assigns(:useradmin))
  end

  test "should destroy useradmin" do
    assert_difference('Useradmin.count', -1) do
      delete :destroy, id: @useradmin
    end

    assert_redirected_to useradmins_path
  end
end
