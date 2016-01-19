class BasePresenter < SimpleDelegator

  def initialize(model)
    super(model)
    @model = model
  end

end
