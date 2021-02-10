require "test_helper"

class AcsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @ac = acs(:one)
  end

  test "should get index" do
    get acs_url
    assert_response :success
  end

  test "should get new" do
    get new_ac_url
    assert_response :success
  end

  test "should create ac" do
    assert_difference('Ac.count') do
      post acs_url, params: { ac: { mode: @ac.mode, status: @ac.status, temperature: @ac.temperature } }
    end

    assert_redirected_to ac_url(Ac.last)
  end

  test "should show ac" do
    get ac_url(@ac)
    assert_response :success
  end

  test "should get edit" do
    get edit_ac_url(@ac)
    assert_response :success
  end

  test "should update ac" do
    patch ac_url(@ac), params: { ac: { mode: @ac.mode, status: @ac.status, temperature: @ac.temperature } }
    assert_redirected_to ac_url(@ac)
  end

  test "should destroy ac" do
    assert_difference('Ac.count', -1) do
      delete ac_url(@ac)
    end

    assert_redirected_to acs_url
  end
end
