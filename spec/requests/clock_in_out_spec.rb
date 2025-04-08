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
      post "/users/#{@user.id}/clock_in", params: { format: 'json' }    end

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

  describe "GET /index" do
    before(:each) do
      @user = User.create(name: "irfan")
      ClockInOut.create(user_id: @user.id, clock_in: DateTime.now, clock_out: DateTime.now)
      ClockInOut.create(user_id: @user.id, clock_in: DateTime.yesterday, clock_out: DateTime.yesterday)
    end

    it "should return a list of clock outs" do
      get "/users/#{@user.id}/clocks", params: { format: 'json' }
      assert_response :success
      expect(assigns(:clock_in_outs)).to_not be_empty
    end

    it "should return paginated data" do
      get "/users/#{@user.id}/clocks", params: { format: 'json', page: 2, per_page: 1 }
      assert_response :success
      expect(assigns(:clock_in_outs)).to_not be_empty
      expect(assigns(:clock_in_outs).size).to eq(1)
    end
  end

  describe "GET /following_user_clocks" do
    let(:follower) { User.create(name: "irfan") }
    let(:followed) { User.create(name: "david") }

    before(:each) do
      Follow.create(follower_id: follower.id, followed_id: followed.id)
      ClockInOut.create(user_id: followed.id,  target_date: DateTime.now.to_date, clock_in: DateTime.now, clock_out: DateTime.now + 9.hours, duration: 9.hours)
      ClockInOut.create(user_id: followed.id,  target_date: DateTime.now.to_date, clock_in: DateTime.now, clock_out: DateTime.now + 1.hours, duration: 1.hours)
      ClockInOut.create(user_id: followed.id,  target_date: DateTime.now.to_date, clock_in: DateTime.now, clock_out: DateTime.now + 3.hours, duration: 3.hours)
    end

    it "should return a list of clock outs" do
      get "/users/#{follower.id}/following_user_clocks", params: { format: 'json' }
      assert_response :success
      expect(assigns(:clock_in_outs)).to_not be_empty
      expect(assigns(:clock_in_outs).first.duration).to eq(9.hours)
      expect(assigns(:clock_in_outs).last.duration).to eq(1.hours)
    end

    it "should return paginated list of clock outs" do
      get "/users/#{follower.id}/following_user_clocks", params: { format: 'json', page: 2, per_page: 1 }
      assert_response :success
      expect(assigns(:clock_in_outs)).to_not be_empty
      expect(assigns(:clock_in_outs).count).to eq(1)
      expect(assigns(:clock_in_outs).last.duration).to eq(3.hours)
    end
  end
end
