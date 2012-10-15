require 'test_helper'

class CmtvotesControllerTest < ActionController::TestCase
  setup do
    @cmtvote = cmtvotes(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:cmtvotes)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create cmtvote" do
    assert_difference('Cmtvote.count') do
      post :create, cmtvote: @cmtvote.attributes
    end

    assert_redirected_to cmtvote_path(assigns(:cmtvote))
  end

  test "should show cmtvote" do
    get :show, id: @cmtvote
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @cmtvote
    assert_response :success
  end

  test "should update cmtvote" do
    put :update, id: @cmtvote, cmtvote: @cmtvote.attributes
    assert_redirected_to cmtvote_path(assigns(:cmtvote))
  end

  test "should destroy cmtvote" do
    assert_difference('Cmtvote.count', -1) do
      delete :destroy, id: @cmtvote
    end

    assert_redirected_to cmtvotes_path
  end
end
