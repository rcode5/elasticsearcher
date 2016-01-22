module Ngram
  class Author < ::Author

    NGRAM_ANALYZER = {
      author_ngram_analyzer: {
        tokenizer: :author_ngram_tokenizer
      }
    }
    NGRAM_TOKENIZER = {
      author_ngram_tokenizer: {
        type: 'nGram',
        min_gram: 4,
        max_gram: 10,
        token_chars: [ :letter, :digit ]
      }
    }

    NGRAM_ANALYZER_TOKENIZER = {
      analyzer: NGRAM_ANALYZER,
      tokenizer: NGRAM_TOKENIZER
    }

    after_commit :add_to_search_index, on: :create
    after_commit :refresh_in_search_index, on: :update
    after_commit :remove_from_search_index, on: :destroy

    def add_to_search_index
      Search::Indexer.index(self)
    end

    def refresh_in_search_index
      Search::Indexer.reindex(self)
    end

    def remove_from_search_index
      Search::Indexer.remove(self)
    end

    self.__elasticsearch__.client = Search::EsClient.root_es_client

    settings(analysis: NGRAM_ANALYZER_TOKENIZER) do
      mappings(_all: {analyzer: :author_ngram_analyzer}) do
        indexes :title, analyzer: :author_ngram_analyzer
        indexes :year
        indexes :medium, analyzer: :author_ngram_analyzer
        indexes :artist_name, analyzer: :author_ngram_analyzer
        indexes :studio_name, analyzer: :author_ngram_analyzer
        indexes :tags, analyzer: :author_ngram_analyzer
      end
    end
  end
end
