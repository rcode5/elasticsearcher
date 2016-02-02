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

    def multi_index_search
      EsClient.client.search(
        {
          index: [:authors, :posts].join(","),
          body: {
            query: {
              match: {
                '_all' => @query
              }
            },
            size: 100,
            highlight: {
              fields: {
                "name" => {},
                "tags" => {},
                "title" => {},
                "artist_name" => {},
                "artist_bio" => {},
                "bio" => {}
              }
            }
          }
        })
    end

    def es_client
      es.client
    end
  end
end
