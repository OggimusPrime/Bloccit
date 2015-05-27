require 'rails_helper'

describe User do
  describe 'favorited post' do
    before do
      @user = create(:user)
      @post1 = create(:post, user: @user)
      @post2 = create(:post, user: @user)
    end

    it 'returns `nil` if the user has favorited another post' do
      @user.favorites.create!(post: @post2)
      expect(@user.favorites.find_by_post_id(@post1.id)).to be nil
    end

    it 'returns `nil` if the user has not favorited the post' do
      expect(@user.favorites.find_by_post_id(@post1.id)).to be nil
    end

    it 'returns the appropriate favorite if it exists' do
      favorite = @user.favorites.create!(post: @post1)
      expect(@user.favorites.find_by_post_id(@post1.id)).to eq(favorite)
    end
  end

  describe '.top-rated' do
    before do
      @user1 = FactoryGirl.create(:user_with_post_and_comment, comment_count: 2)

      @user2 = FactoryGirl.create(:user_with_post_and_comment)
    end

    it 'returns users ordered by comments + posts' do
      expect(User.top_rated).to eq([@user1, @user2])
    end

    it 'stores a `posts_count` on user' do
      users = User.top_rated
      expect(users.first.posts_count).to eq(1)
    end

    it 'stores a `comments_count` on user' do
      users = User.top_rated
      expect(users.first.comments_count).to eq(2)
    end
  end
end
