require 'test_helper'

class ReviewPostsControllerTest < ActionController::TestCase
  setup do
    @review_post = review_posts(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:review_posts)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create review_post" do
    assert_difference('ReviewPost.count') do
      post :create, review_post: {  }
    end

    assert_redirected_to review_post_path(assigns(:review_post))
  end

  test "should show review_post" do
    get :show, id: @review_post
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @review_post
    assert_response :success
  end

  test "should update review_post" do
    patch :update, id: @review_post, review_post: {  }
    assert_redirected_to review_post_path(assigns(:review_post))
  end

  test "should destroy review_post" do
    assert_difference('ReviewPost.count', -1) do
      delete :destroy, id: @review_post
    end

    assert_redirected_to review_posts_path
  end
end
