require 'test_helper'

class UserAdminsControllerTest < ActionController::TestCase
  setup do
    @user_admin = user_admins(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:user_admins)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create user_admin" do
    assert_difference('UserAdmin.count') do
      post :create, user_admin: { name: @user_admin.name, password: @user_admin.password, username: @user_admin.username }
    end

    assert_redirected_to user_admin_path(assigns(:user_admin))
  end

  test "should show user_admin" do
    get :show, id: @user_admin
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @user_admin
    assert_response :success
  end

  test "should update user_admin" do
    patch :update, id: @user_admin, user_admin: { name: @user_admin.name, password: @user_admin.password, username: @user_admin.username }
    assert_redirected_to user_admin_path(assigns(:user_admin))
  end

  test "should destroy user_admin" do
    assert_difference('UserAdmin.count', -1) do
      delete :destroy, id: @user_admin
    end

    assert_redirected_to user_admins_path
  end
end
