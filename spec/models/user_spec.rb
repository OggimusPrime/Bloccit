require 'rails_helper'

describe User do

  include TestFactories

  describe "#favorited(post)" do
    before do
      @post = associated_post
      @user = authenticated_user
      @another_post = associated_post
    end

    it "returns `nil` if the user has favorited another post" do
      @user.favorites.create!(post: @another_post)
      expect( @user.favorites.find_by_post_id(@post.id) ).to be nil 
    end

    it "returns `nil` if the user has not favorited the post" do
      expect( @user.favorites.find_by_post_id(@post.id) ).to be nil 
    end

    it "returns the appropriate favorite if it exists" do
      favorite = @user.favorites.create!(post: @post)
      expect( @user.favorites.find_by_post_id(@post.id) ).to eq(favorite)
    end
  end
end