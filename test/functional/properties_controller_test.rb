require 'test_helper'

class PropertiesControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:properties)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create property" do
    assert_difference('Property.count') do
      post :create, :property => { }
    end

    assert_redirected_to property_path(assigns(:property))
  end

  test "should show property" do
    get :show, :id => properties(:one).to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => properties(:one).to_param
    assert_response :success
  end

  test "should update property" do
    put :update, :id => properties(:one).to_param, :property => { }
    assert_redirected_to property_path(assigns(:property))
  end

  test "should destroy property" do
    assert_difference('Property.count', -1) do
      delete :destroy, :id => properties(:one).to_param
    end

    assert_redirected_to properties_path
  end
end
