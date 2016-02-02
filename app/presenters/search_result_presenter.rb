class SearchResultPresenter < BasePresenter

  EXCLUDED_ATTRIBUTES = %w| created_at updated_at |

  def initialize(result)
    super(result)
    @model = result
  end

  def score
    "%2.2f" % @model.score
  end

  def fields
    [:score, :type, @model.source.to_hash.except( *EXCLUDED_ATTRIBUTES ).keys ].flatten
  end

  def each(&block)
    fields.each do |field|
      block.call field, self.send(field)
    end
  end

end
