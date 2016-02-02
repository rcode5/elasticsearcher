module Search
  class Response < SimpleDelegator

    def initialize(results)
      results ||= {}
      super(results)
      @source = results
    end

    def results
      return [] unless @source.has_key?('hits') && @source['hits'].has_key?('hits')

      @source['hits']['hits'].map { |hit| Search::Result.new(hit) }
    end

  end
end
