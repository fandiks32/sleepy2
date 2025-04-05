require "test_helper"

class ClockInOutsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @clock_in_out = clock_in_outs(:one)
  end

  test "should get index" do
    get clock_in_outs_url
    assert_response :success
  end

  test "should get new" do
    get new_clock_in_out_url
    assert_response :success
  end

  test "should create clock_in_out" do
    assert_difference("ClockInOut.count") do
      post clock_in_outs_url, params: { clock_in_out: { clock_in: @clock_in_out.clock_in, clock_out: @clock_in_out.clock_out, duration: @clock_in_out.duration, target_date: @clock_in_out.target_date, user_id: @clock_in_out.user_id } }
    end

    assert_redirected_to clock_in_out_url(ClockInOut.last)
  end

  test "should show clock_in_out" do
    get clock_in_out_url(@clock_in_out)
    assert_response :success
  end

  test "should get edit" do
    get edit_clock_in_out_url(@clock_in_out)
    assert_response :success
  end

  test "should update clock_in_out" do
    patch clock_in_out_url(@clock_in_out), params: { clock_in_out: { clock_in: @clock_in_out.clock_in, clock_out: @clock_in_out.clock_out, duration: @clock_in_out.duration, target_date: @clock_in_out.target_date, user_id: @clock_in_out.user_id } }
    assert_redirected_to clock_in_out_url(@clock_in_out)
  end

  test "should destroy clock_in_out" do
    assert_difference("ClockInOut.count", -1) do
      delete clock_in_out_url(@clock_in_out)
    end

    assert_redirected_to clock_in_outs_url
  end
end
