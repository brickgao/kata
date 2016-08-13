class Node < ActiveRecord::Base
  has_many :posts
  validates :name, presence: true
  validates :summary, presence: true
end
