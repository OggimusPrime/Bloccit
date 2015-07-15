class Post < ActiveRecord::Base
  has_many :comments, dependent: :destroy
  has_many :votes, dependent: :destroy
  has_many :favorites, dependent: :destroy
  belongs_to :user
  belongs_to :topic

  default_scope { order('rank DESC') }
  scope :visible_to, lambda { |user|
    user ? all : joins(:topic).where('topics.public' => true)
  }

  # scope :order_by_title, -> { order('title') }
  # scope :order_by_reverse_created, -> { order('created_at DESC') }

  validates :title, length: { minimum: 5 }, presence: true
  validates :body, length: { minimum: 20 }, presence: true
  validates :topic, presence: true
  validates :user, presence: true

  def up_votes
    votes.where(value: 1).count
  end

  def down_votes
    votes.where(value: -1).count
  end

  def points
    votes.sum(:value)
  end

  def update_rank
    # (60 * 60 * 24) ~ 1 day in seconds
    age_in_days = (created_at - Time.new(1970, 1, 1)) / (60 * 60 * 24)
    new_rank = points + age_in_days
    # update rank with new_rank
    update_attribute(:rank, new_rank)
  end

  def create_vote
    user.votes.create(value: 1, post: self)
  end

  # called from Post#create to set initial up vote on own post
  def initial_vote
    ActiveRecord::Base.transaction do
      create_vote
    end
  end
end
