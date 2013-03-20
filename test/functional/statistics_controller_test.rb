require 'test_helper'

class StatisticsControllerTest < ActionController::TestCase
  setup do
    @statistic = statistics(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:statistics)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create statistic" do
    assert_difference('Statistic.count') do
      post :create, statistic: { falarmy: @statistic.falarmy, pozary: @statistic.pozary, rok: @statistic.rok, zagrozenia: @statistic.zagrozenia }
    end

    assert_redirected_to statistic_path(assigns(:statistic))
  end

  test "should show statistic" do
    get :show, id: @statistic
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @statistic
    assert_response :success
  end

  test "should update statistic" do
    put :update, id: @statistic, statistic: { falarmy: @statistic.falarmy, pozary: @statistic.pozary, rok: @statistic.rok, zagrozenia: @statistic.zagrozenia }
    assert_redirected_to statistic_path(assigns(:statistic))
  end

  test "should destroy statistic" do
    assert_difference('Statistic.count', -1) do
      delete :destroy, id: @statistic
    end

    assert_redirected_to statistics_path
  end
end
