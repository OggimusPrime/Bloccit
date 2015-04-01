require 'rails_helper'

include TestFactories

include Warden::Test::Helpers
Warden.test_mode!

describe "Visiting profiles" do 

  before do
    @user = authenticated_user
    @post = associated_post(user: @user)
    @comment = @post.comments.build(user: @user, body: "A Comment")
    comment_without_email(@comment)
  end

  describe "not signed in" do

    it "shows profile" do
      visit user_path(@user)
      expect(current_path).to eq(user_path(@user))

      expect( page ).to have_content(@user.name)
      expect( page ).to have_content(@post.title)
      expect( page ).to have_content(@comment.body)
    end

  end

  describe "signed in and viewing own profile" do

    before do
      login_as(@user, :scope => :user)
    end

    it "shows profile" do
      visit user_path(@user)
      expect(current_path).to eq(user_path(@user))

      expect( page ).to have_content(@user.name)
      expect( page ).to have_content(@post.title)
      expect( page ).to have_content(@comment.body)
    end

  end
end