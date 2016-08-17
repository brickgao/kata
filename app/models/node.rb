class Node < ActiveRecord::Base
  has_many :posts
  validates :name, presence: true
  validates :summary, presence: true, length: { minimm: 5, maximum: 50 }
end
