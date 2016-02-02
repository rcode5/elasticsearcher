module ES
  module Controller
    extend ActiveSupport::Concern

    included do
      before_action :set_model_class, :set_query, :set_results_dom_id, only: [:search]
    end

    def search
      es_results = @model_class.search(@query)
      @search_results = SearchResultsPresenter.new(Search::Response.new(es_results.response))
      respond_to do |fmt|
        fmt.js { render '/common/search' }
        fmt.html { }
      end
    end

    private

    def set_results_dom_id
      @results_dom_id = params[:results_dom_id]
    end

    def set_model_class
      @model_class = params[:controller].classify.constantize
    end

    def set_query
      @query = params[:query].to_s.strip
    end

    def set_query
      @query = params[:query].to_s.strip
    end

  end
end
