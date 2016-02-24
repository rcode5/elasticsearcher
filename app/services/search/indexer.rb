module Search
  class Indexer

    DEFAULT_INDEX_OPTIONS = { number_of_shards: 1 }

    NGRAM_ANALYZER = {
      ngram_analyzer: {
        tokenizer: :ngram_tokenizer
      }
    }
    NGRAM_TOKENIZER = {
      ngram_tokenizer: {
        type: 'nGram',
        min_gram: 3,
        max_gram: 10,
        token_chars: [ :letter, :digit ]
      }
    }

    SNOWBALL_ANALYZER = {
      snowball_analyzer: {
        type: :snowball,
        language: "English",
        filter: %w| standard lowercase |
      }
    }

    DEFAULT_ANALYSIS_OPTIONS = {
      analyzer: {}.merge(NGRAM_ANALYZER).merge(SNOWBALL_ANALYZER),
      tokenizer: {}.merge(NGRAM_TOKENIZER)
    }

  end
end
