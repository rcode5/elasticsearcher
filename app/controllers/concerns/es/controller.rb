module ES
  module Controller
    extend ActiveSupport::Concern

    included do
      before_action :set_model_class, :set_query, only: [:search]
    end

    def search
      es_results = @model_class.search(@query)
      @search_results = es_results.results.results
    end

    private

    def set_model_class
      @model_class = params[:controller].classify.constantize
    end

    def set_query
      @query = params[:query].to_s.strip
    end

  end
end
