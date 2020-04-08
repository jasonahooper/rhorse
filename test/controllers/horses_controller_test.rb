require 'test_helper'

class HorsesControllerTest < ActionController::TestCase
  setup do
    @horse = horses(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:horses)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create horse" do
    assert_difference('Horse.count') do
      post :create, params: { horse: { dam_id: @horse.dam_id, name: @horse.name, sex: @horse.sex, sire_id: @horse.sire_id, year: @horse.year } }
    end

    assert_redirected_to horse_path(assigns(:horse))
  end

  test "should show horse" do
    get :show, params: { id: @horse }
    assert_response :success
  end

  test "should get edit" do
    get :edit, params: { id: @horse }
    assert_response :success
  end

  test "should update horse" do
    patch :update, params: { id: @horse, horse: { dam_id: @horse.dam_id, name: @horse.name, sex: @horse.sex, sire_id: @horse.sire_id, year: @horse.year } }
    assert_redirected_to horse_path(assigns(:horse))
  end

  test "should destroy horse" do
    assert_difference('Horse.count', -1) do
      delete :destroy, params: { id: @horse }
    end

    assert_redirected_to horses_path
  end
end
