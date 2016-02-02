require 'ostruct'

class SearchController < ApplicationController

  before_action :set_query

  def search
    @search_results = SearchResultsPresenter.new(Search::QueryRunner.new(@query).search.results)
    respond_to do |fmt|
      fmt.js {
        @model_class = OpenStruct.new(name: "All")
        render '/common/search'
      }
      fmt.html { }
    end
  end

  def set_query
    @query = params[:query]
  end
end
