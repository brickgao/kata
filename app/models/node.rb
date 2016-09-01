class Node < ActiveRecord::Base
  has_many :posts
  validates :name, presence: true, length: { minimum: 3, maximum: 30 }
  validates :summary, presence: true, length: { minimum: 5, maximum: 50 }
end
