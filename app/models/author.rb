require 'elasticsearch/model'

class Author < ActiveRecord::Base

  validates :name, presence: true

  include Elasticsearch::Model
  include Elasticsearch::Model::Callbacks

  settings(
    analysis: Search::Indexer::DEFAULT_ANALYSIS_OPTIONS,
    index: Search::Indexer::DEFAULT_INDEX_OPTIONS
  )
  mapping do
    indexes :name
    indexes :hometown
    indexes :ngram_name, analyzer: :ngram_analyzer
    indexes :ngram_hometown, analyzer: :ngram_analyzer
    indexes :snowball_name, analyzer: :snowball_analyzer
    indexes :snowball_hometown, analyzer: :snowball_analyzer
  end

  def as_indexed_json(opts = {})
    as_json(opts.merge({except: [:created_at, :updated_at, :id]})).merge({
                          ngram_name: name,
                          ngram_hometown: hometown,
                          snowball_name: name,
                          snowball_hometown: hometown
                        })
  end

end
