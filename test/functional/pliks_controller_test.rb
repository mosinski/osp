require 'test_helper'

class PliksControllerTest < ActionController::TestCase
  setup do
    @plik = pliks(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:pliks)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create plik" do
    assert_difference('Plik.count') do
      post :create, plik: {  }
    end

    assert_redirected_to plik_path(assigns(:plik))
  end

  test "should show plik" do
    get :show, id: @plik
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @plik
    assert_response :success
  end

  test "should update plik" do
    put :update, id: @plik, plik: {  }
    assert_redirected_to plik_path(assigns(:plik))
  end

  test "should destroy plik" do
    assert_difference('Plik.count', -1) do
      delete :destroy, id: @plik
    end

    assert_redirected_to pliks_path
  end
end
