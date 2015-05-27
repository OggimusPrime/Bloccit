class Vote < ActiveRecord::Base
  belongs_to :user
  belongs_to :post

  # User's vote should only be either +1 or -1
  validates :value, inclusion: {
    in: [-1, 1],
    message: '%{value} is not a valid vote.'
  }

  # Updates post with new vote value
  after_save :update_post

  def up_vote?
    value == 1
  end

  def down_vote?
    value == -1
  end

  private

  def update_post
    post.update_rank
  end
end
