require "application_system_test_case"

class ClockInOutsTest < ApplicationSystemTestCase
  setup do
    @clock_in_out = clock_in_outs(:one)
  end

  test "visiting the index" do
    visit clock_in_outs_url
    assert_selector "h1", text: "Clock in outs"
  end

  test "should create clock in out" do
    visit clock_in_outs_url
    click_on "New clock in out"

    fill_in "Clock in", with: @clock_in_out.clock_in
    fill_in "Clock out", with: @clock_in_out.clock_out
    fill_in "Duration", with: @clock_in_out.duration
    fill_in "Target date", with: @clock_in_out.target_date
    fill_in "User", with: @clock_in_out.user_id
    click_on "Create Clock in out"

    assert_text "Clock in out was successfully created"
    click_on "Back"
  end

  test "should update Clock in out" do
    visit clock_in_out_url(@clock_in_out)
    click_on "Edit this clock in out", match: :first

    fill_in "Clock in", with: @clock_in_out.clock_in
    fill_in "Clock out", with: @clock_in_out.clock_out
    fill_in "Duration", with: @clock_in_out.duration
    fill_in "Target date", with: @clock_in_out.target_date
    fill_in "User", with: @clock_in_out.user_id
    click_on "Update Clock in out"

    assert_text "Clock in out was successfully updated"
    click_on "Back"
  end

  test "should destroy Clock in out" do
    visit clock_in_out_url(@clock_in_out)
    click_on "Destroy this clock in out", match: :first

    assert_text "Clock in out was successfully destroyed"
  end
end
