require 'test_helper'

class DayCollectionsControllerTest < ActionController::TestCase
  setup do
    @day_collection = day_collections(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:day_collections)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create day_collection" do
    assert_difference('DayCollection.count') do
      post :create, day_collection: { shift_id: @day_collection.shift_id, status_id: @day_collection.status_id, user_id: @day_collection.user_id }
    end

    assert_redirected_to day_collection_path(assigns(:day_collection))
  end

  test "should show day_collection" do
    get :show, id: @day_collection
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @day_collection
    assert_response :success
  end

  test "should update day_collection" do
    put :update, id: @day_collection, day_collection: { shift_id: @day_collection.shift_id, status_id: @day_collection.status_id, user_id: @day_collection.user_id }
    assert_redirected_to day_collection_path(assigns(:day_collection))
  end

  test "should destroy day_collection" do
    assert_difference('DayCollection.count', -1) do
      delete :destroy, id: @day_collection
    end

    assert_redirected_to day_collections_path
  end
end
