require 'elasticsearch/model'

class Author < ActiveRecord::Base

  validates :name, presence: true

  include Elasticsearch::Model
  include Elasticsearch::Model::Callbacks

end
