class Node < ActiveRecord::Base
  has_many :posts
  validates :name, presence: true, length: { minimum: 3, maximum: 30 }
  validates :summary, presence: true, length: { minimum: 5, maximum: 50 }
  VALID_ICON_URL_REGEX = /https?:\/\/[\S]+.(.jpg|.png|.gif)/
  validates :icon_url, presence: true, length: { maximum: 300 },
                       format: { with: VALID_ICON_URL_REGEX }
end
