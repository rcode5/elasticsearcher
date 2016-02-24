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
    indexes :snowball_title, analyzer: :snowball_analyzer
    indexes :snowball_body, analyzer: :snowball_analyzer
  end

  def as_indexed_json(opts = {})
    as_json(opts.merge({except: [:created_at, :updated_at, :id]})).merge({
                          ngram_title: title,
                          ngram_body: body,
                          snowball_title: title,
                          snowball_body: body
                        })
  end
end
