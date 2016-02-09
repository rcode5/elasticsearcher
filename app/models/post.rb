require 'elasticsearch/model'

class Post < ActiveRecord::Base

  validates :title, presence: true

  include Elasticsearch::Model
  include Elasticsearch::Model::Callbacks

  settings(
    analysis: Search::Indexer::DEFAULT_ANALYSIS_OPTIONS,
    index: Search::Indexer::DEFAULT_INDEX_OPTIONS
  )
  mapping do
    indexes :title
    indexes :ngram_title, analyzer: :ngram_analyzer
    indexes :ngram_body, analyzer: :ngram_analyzer
  end

end
