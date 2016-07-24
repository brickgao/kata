class Message < ActiveRecord::Base
  belongs_to :from, :class_name => "User"
  belongs_to :to, :class_name => "User"
  validates :body, presence: true, length: { minimum: 5, maximum: 200 }
  validates :is_read, presence: true
end
