# initialize with an array of results
class SearchResultsPresenter < BasePresenter

  def by_type
    @model.results.inject({}) do |memo, result|
      memo[result.type] ||= []
      memo[result.type] << SearchResultPresenter.new(result)
      memo
    end
  end

end
