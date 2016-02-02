require 'ostruct'

class SearchController < ApplicationController

  before_action :set_query, :set_results_dom_id
  def search
    @search_results = SearchResultsPresenter.new(Search::QueryRunner.new(@query).search)
    respond_to do |fmt|
      fmt.js {
        @model_class = OpenStruct.new(name: "All")
        render '/common/search'
      }
      fmt.html { }
    end
  end

  def set_query
    @query = params[:query].to_s.strip
  end

  def set_results_dom_id
    @results_dom_id = params[:results_dom_id]
  end
end
