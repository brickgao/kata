class Post < ActiveRecord::Base
  belongs_to :node
  validates :title, presence: true, length: { minimum: 8 }
  validates :body, presence: true, length: { minimum: 8 }
  validates :node, presence: true
end
