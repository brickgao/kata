class Post < ActiveRecord::Base
  belongs_to :node
  belongs_to :user
  validates :title, presence: true, length: { minimum: 8 }
  validates :body, presence: true, length: { minimum: 8 }
  validates :node, presence: true
  validates :user, presence: true
end
