require 'test_helper'

class OpenstackUsersControllerTest < ActionController::TestCase
  setup do
    @openstack_user = openstack_users(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:openstack_users)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create openstack_user" do
    assert_difference('OpenstackUser.count') do
      post :create, openstack_user: { os_auth_url: @openstack_user.os_auth_url, os_password: @openstack_user.os_password, os_username: @openstack_user.os_username }
    end

    assert_redirected_to openstack_user_path(assigns(:openstack_user))
  end

  test "should show openstack_user" do
    get :show, id: @openstack_user
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @openstack_user
    assert_response :success
  end

  test "should update openstack_user" do
    patch :update, id: @openstack_user, openstack_user: { os_auth_url: @openstack_user.os_auth_url, os_password: @openstack_user.os_password, os_username: @openstack_user.os_username }
    assert_redirected_to openstack_user_path(assigns(:openstack_user))
  end

  test "should destroy openstack_user" do
    assert_difference('OpenstackUser.count', -1) do
      delete :destroy, id: @openstack_user
    end

    assert_redirected_to openstack_users_path
  end
end
