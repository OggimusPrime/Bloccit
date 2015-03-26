class Topic < ActiveRecord::Base
  extend Paginate
  has_many :posts

  validates :name, length: { minimum: 5 }, presence: true

end
