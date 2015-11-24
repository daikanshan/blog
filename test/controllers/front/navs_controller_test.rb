require 'test_helper'

class Front::NavsControllerTest < ActionController::TestCase
  setup do
    @front_nav = front_navs(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:front_navs)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create front_nav" do
    assert_difference('Front::Nav.count') do
      post :create, front_nav: { code: @front_nav.code, father_id: @front_nav.father_id, icon: @front_nav.icon, level: @front_nav.level, shown: @front_nav.shown, text: @front_nav.text, url: @front_nav.url, user_id: @front_nav.user_id, weight: @front_nav.weight }
    end

    assert_redirected_to front_nav_path(assigns(:front_nav))
  end

  test "should show front_nav" do
    get :show, id: @front_nav
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @front_nav
    assert_response :success
  end

  test "should update front_nav" do
    patch :update, id: @front_nav, front_nav: { code: @front_nav.code, father_id: @front_nav.father_id, icon: @front_nav.icon, level: @front_nav.level, shown: @front_nav.shown, text: @front_nav.text, url: @front_nav.url, user_id: @front_nav.user_id, weight: @front_nav.weight }
    assert_redirected_to front_nav_path(assigns(:front_nav))
  end

  test "should destroy front_nav" do
    assert_difference('Front::Nav.count', -1) do
      delete :destroy, id: @front_nav
    end

    assert_redirected_to front_navs_path
  end
end
