require 'test_helper'

class CrpytoInfosControllerTest < ActionDispatch::IntegrationTest
  setup do
    @crpyto_info = crpyto_infos(:one)
  end

  test "should get index" do
    get crpyto_infos_url
    assert_response :success
  end

  test "should get new" do
    get new_crpyto_info_url
    assert_response :success
  end

  test "should create crpyto_info" do
    assert_difference('CrpytoInfo.count') do
      post crpyto_infos_url, params: { crpyto_info: { date: @crpyto_info.date, ticker: @crpyto_info.ticker } }
    end

    assert_redirected_to crpyto_info_url(CrpytoInfo.last)
  end

  test "should show crpyto_info" do
    get crpyto_info_url(@crpyto_info)
    assert_response :success
  end

  test "should get edit" do
    get edit_crpyto_info_url(@crpyto_info)
    assert_response :success
  end

  test "should update crpyto_info" do
    patch crpyto_info_url(@crpyto_info), params: { crpyto_info: { date: @crpyto_info.date, ticker: @crpyto_info.ticker } }
    assert_redirected_to crpyto_info_url(@crpyto_info)
  end

  test "should destroy crpyto_info" do
    assert_difference('CrpytoInfo.count', -1) do
      delete crpyto_info_url(@crpyto_info)
    end

    assert_redirected_to crpyto_infos_url
  end
end
