module Search

  class InvalidQueryTypeError < StandardError; end

  class QueryRunner

    AVAILABLE_TYPES = %w|standard snowball ngram proximity_scoring|
    DEFAULT_QUERY_TYPE = :standard

    attr_reader :type, :query

    def initialize(query, type: nil)
      @type = type || DEFAULT_QUERY_TYPE

      raise Search::InvalidQueryTypeError.new("#{@type} is not a valid query type.  Try one of these: #{AVAILABLE_TYPES.join(',')}") unless AVAILABLE_TYPES.include?(@type.to_s)

      @query = query
    end

    def search
      t = Time.now.to_f
      return [] unless @query.present?
      results = multi_index_search
      Search::Response.new(results)
    end

    def query_body
      QueryBody.send(type, query)
    end

    def multi_index_search
      search_params = {
        index: [:authors, :posts].join(","),
        body: query_body
      }
      puts "ES Query: #{query_body.to_json}"
      EsClient.client.search(search_params)
    end

    def es_client
      es.client
    end

    private

    class QueryBody
      def self.snowball(query)
        {
          query: {
            multi_match: {
              query: query,
              type: :best_fields,
              fields: %w| snowball_title snowball_body snowball_name snowball_hometown |
            }
          },
          size: 100,
          highlight: {
            pre_tags: ["<strong>"],
            post_tags: ["</strong>"],
            fields: {
              '*' => {},
            }
          }
        }
      end

      def self.ngram(query)
        {
          query: {
            multi_match: {
              query: query,
              type: :best_fields,
              fields: %w| ngram_title ngram_body ngram_name ngram_hometown |
            }
          },
          size: 100,
          highlight: {
            pre_tags: ["<strong>"],
            post_tags: ["</strong>"],
            fields: {
              '*' => {},
            }
          }
        }
      end

      def self.standard(query)
        fields_across_models = %w| _all title body name hometown |
        {
          query: {
            multi_match: {
              query: query,
              type: :best_fields, # default - could be left out
              fields: fields_across_models
            }
          },
          size: 100,
          highlight: {
            pre_tags: ["<strong>"],
            post_tags: ["</strong>"],
            fields: {
              '_all' => {},
              'title' => {},
              'body' => {},
              'hometown' => {},
              'name' => {}
            }
          }
        }
      end

      def self.proximity_scoring(query)
        fields_across_models = %w| _all title body name hometown |
        {
          query: {
            bool: {
              must: {
                match: {
                  title: {
                    query: query,
                  }
                }
              },
              should: {
                match_phrase: {
                  title: {
                    query: query,
                    slop: 53,
                  }
                }
              }
            }
          },
          size: 100,
          highlight: {
            pre_tags: ["<strong>"],
            post_tags: ["</strong>"],
            fields: {
              '_all' => {},
              'title' => {},
              'body' => {},
              'hometown' => {},
              'name' => {}
            }
          }
        }
      end

    end
  end
end
