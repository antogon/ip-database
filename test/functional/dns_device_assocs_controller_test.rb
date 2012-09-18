require 'test_helper'

class DnsDeviceAssocsControllerTest < ActionController::TestCase
  setup do
    @dns_device_assoc = dns_device_assocs(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:dns_device_assocs)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create dns_device_assoc" do
    assert_difference('DnsDeviceAssoc.count') do
      post :create, dns_device_assoc: {  }
    end

    assert_redirected_to dns_device_assoc_path(assigns(:dns_device_assoc))
  end

  test "should show dns_device_assoc" do
    get :show, id: @dns_device_assoc
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @dns_device_assoc
    assert_response :success
  end

  test "should update dns_device_assoc" do
    put :update, id: @dns_device_assoc, dns_device_assoc: {  }
    assert_redirected_to dns_device_assoc_path(assigns(:dns_device_assoc))
  end

  test "should destroy dns_device_assoc" do
    assert_difference('DnsDeviceAssoc.count', -1) do
      delete :destroy, id: @dns_device_assoc
    end

    assert_redirected_to dns_device_assocs_path
  end
end
