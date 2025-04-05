require 'rails_helper'

RSpec.describe "ClockInOuts", type: :request do
  describe "POST /clock_in" do
    before(:each) do
      @user = User.create(name: "irfan")
    end

    it "should able to clock in" do
      post "/users/#{@user.id}/clock_in", params: { format: 'json' }
      assert_response :success
    end
  end

  describe "POST /clock_out" do
    before(:each) do
      @user = User.create(name: "irfan")
      post "/users/#{@user.id}/clock_in", params: { format: 'json' }
    end

    it "should able to clock out successfully" do
      post "/users/#{@user.id}/clock_out", params: { format: 'json' }
      assert_response :success
    end

    it "should not able to twice clock out" do
      post "/users/#{@user.id}/clock_out", params: { format: 'json' }
      sleep(1)
      post "/users/#{@user.id}/clock_out", params: { format: 'json' }
      assert_response :unprocessable_entity
    end
  end
end
