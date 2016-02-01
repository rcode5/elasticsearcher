# initialize with an array of results
class SearchResultsPresenter < BasePresenter

  def results
    @model.map { |result| SearchResultPresenter.new(result) }
  end

  def by_type
    @model.inject({}) do |memo, result|
      memo[result._type] ||= []
      memo[result._type] << SearchResultPresenter.new(result)
      memo
    end
  end
end
