require 'test_helper'

class DhcpRangesControllerTest < ActionController::TestCase
  setup do
    @dhcp_range = dhcp_ranges(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:dhcp_ranges)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create dhcp_range" do
    assert_difference('DhcpRange.count') do
      post :create, dhcp_range: {  }
    end

    assert_redirected_to dhcp_range_path(assigns(:dhcp_range))
  end

  test "should show dhcp_range" do
    get :show, id: @dhcp_range
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @dhcp_range
    assert_response :success
  end

  test "should update dhcp_range" do
    put :update, id: @dhcp_range, dhcp_range: {  }
    assert_redirected_to dhcp_range_path(assigns(:dhcp_range))
  end

  test "should destroy dhcp_range" do
    assert_difference('DhcpRange.count', -1) do
      delete :destroy, id: @dhcp_range
    end

    assert_redirected_to dhcp_ranges_path
  end
end
