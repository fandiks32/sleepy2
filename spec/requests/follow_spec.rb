require 'rails_helper'

RSpec.describe "Follows", type: :request do
  describe "POST /create" do
    let(:follower) { User.create(name: "irfan") }
    let(:followed) { User.create(name: "david") }

    it "should creates a follow" do
      post "/users/#{follower.id}/follows", params: { format: 'json', follow: { follower_id: follower.id, followed_id: followed.id } }
      assert_response :success
      expect(Follow.where(follower_id: follower.id).count).to eq(1)
    end

    it "should not create double follow" do
      post "/users/#{follower.id}/follows", params: { format: 'json', follow: { follower_id: follower.id, followed_id: followed.id } }
      post "/users/#{follower.id}/follows", params: { format: 'json', follow: { follower_id: follower.id, followed_id: followed.id } }
      assert_response :unprocessable_entity
      expect(Follow.where(follower_id: follower.id).count).to eq(1)
    end


    it "should not create a follow" do
      post "/users/#{follower.id}/follows", params: { format: 'json', follow: { follower_id: follower.id, followed_id: 9999999 } }
      assert_response :unprocessable_entity
      expect(Follow.where(follower_id: follower.id).count).to eq(0)
    end
  end

  describe "DELETE /destroy" do
    let(:follower) { User.create(name: "irfan") }
    let(:followed) { User.create(name: "david") }

    it "should delete a follow" do
      f = Follow.create!(follower_id: follower.id, followed_id: followed.id)

      delete "/users/#{follower.id}/follows/#{f.id}", params: { format: 'json' }
      assert_response :no_content
    end
  end

  describe "POST /unfollow" do
    let(:follower) { User.create(name: "irfan") }
    let(:followed) { User.create(name: "david") }

    it "should unfollow a follow" do
      f = Follow.create!(follower_id: follower.id, followed_id: followed.id)

      delete "/users/#{follower.id}/unfollow", params: { format: 'json', followed_id: followed.id }
      assert_response :no_content
      expect(Follow.where(follower_id: follower.id, followed_id: followed.id).count).to eq(0)
    end
  end
end
