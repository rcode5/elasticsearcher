require 'elasticsearch/model'

class Post < ActiveRecord::Base

  validates :title, presence: true

  include Elasticsearch::Model
  include Elasticsearch::Model::Callbacks

end

Post.import force: true
