require 'elasticsearch/model'


class Post < ActiveRecord::Base
  include Elasticsearch::Model
  include Elasticsearch::Model::Callbacks

  belongs_to :node
  belongs_to :user
  has_many :comments
  validates :title, presence: true, length: { minimum: 8 }
  validates :body, presence: true, length: { minimum: 8 }
  validates :node, presence: true
  validates :user, presence: true
  validates :enable_markdown, presence: true
end
