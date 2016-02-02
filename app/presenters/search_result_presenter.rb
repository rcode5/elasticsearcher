class SearchResultPresenter < BasePresenter

  EXCLUDED_ATTRIBUTES = %w| created_at updated_at |

  def type
    @model._type
  end

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
    attrs = {
      type: type
    }.merge @model._source.to_hash.except( *EXCLUDED_ATTRIBUTES )
    attrs.each(&block)
  end

end
