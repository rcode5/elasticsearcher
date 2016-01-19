class SearchResultPresenter < BasePresenter

  def source
    @model._source
  end

  def fields
    @model._source.keys
  end

  def value(fld)
    @model._source[fld]
  end

  def attributes(&block)
    @model._source.to_hash.each(&block)
  end

end
