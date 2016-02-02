require 'elasticsearch/model'

class Post < ActiveRecord::Base

  validates :title, presence: true

  include Elasticsearch::Model
  include Elasticsearch::Model::Callbacks

  # settings(
  #   analysis: Search::Indexer::DEFAULT_ANALYSIS_OPTIONS,
  #   index: Search::Indexer::DEFAULT_INDEX_OPTIONS
  # ) do
  #   mappings(ngram_title: {analyzer: :ngram_analyzer}) do
  #     indexes :title, analyzer: :ngram_analyzer
  #     indexes :body
  #   end
  # end


end
