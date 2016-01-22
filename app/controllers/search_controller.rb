class SearchController < ApplicationController
  def search
    @search_results = Search::QueryRunner.new(@query).search.map { |result|
      SearchResultPresenter.new(result)
    }
    respond_to do |fmt|
      fmt.js { render '/common/search' }
      fmt.html { }
    end
  end
end
