module Search
  class QueryRunner
    def initialize(query = nil, include_highlight = true)
      @query = query
    end

    def search
      t = Time.now.to_f
      return [] unless @query.present?
      results = multi_index_search
      Search::Response.new(results)
    end

    def query_body
      fields_across_models = %w| _all title body name hometown |
      {
        query: {
          multi_match: {
            query: @query,
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
  end
end
