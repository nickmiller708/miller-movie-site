require 'test_helper'

class RelevantLinksControllerTest < ActionController::TestCase
  setup do
    @relevant_link = relevant_links(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:relevant_links)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create relevant_link" do
    assert_difference('RelevantLink.count') do
      post :create, relevant_link: {  }
    end

    assert_redirected_to relevant_link_path(assigns(:relevant_link))
  end

  test "should show relevant_link" do
    get :show, id: @relevant_link
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @relevant_link
    assert_response :success
  end

  test "should update relevant_link" do
    patch :update, id: @relevant_link, relevant_link: {  }
    assert_redirected_to relevant_link_path(assigns(:relevant_link))
  end

  test "should destroy relevant_link" do
    assert_difference('RelevantLink.count', -1) do
      delete :destroy, id: @relevant_link
    end

    assert_redirected_to relevant_links_path
  end
end
