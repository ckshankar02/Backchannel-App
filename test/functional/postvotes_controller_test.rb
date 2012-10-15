require 'test_helper'

class PostvotesControllerTest < ActionController::TestCase
  setup do
    @postvote = postvotes(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:postvotes)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create postvote" do
    assert_difference('Postvote.count') do
      post :create, postvote: @postvote.attributes
    end

    assert_redirected_to postvote_path(assigns(:postvote))
  end

  test "should show postvote" do
    get :show, id: @postvote
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @postvote
    assert_response :success
  end

  test "should update postvote" do
    put :update, id: @postvote, postvote: @postvote.attributes
    assert_redirected_to postvote_path(assigns(:postvote))
  end

  test "should destroy postvote" do
    assert_difference('Postvote.count', -1) do
      delete :destroy, id: @postvote
    end

    assert_redirected_to postvotes_path
  end
end
