module HistogramHelpers

  def histogram_of(ar_model, field)
    elements = ar_model.pluck(field).map { |v| v.to_s.split.map(&:strip) }.flatten
    histogram(elements)
  end

  def histogram(array)
    Hash[*array.group_by{ |v| v }.flat_map{ |k, v| [k, v.size] }]
  end

end

RSpec.configure do |config|
  config.include HistogramHelpers
end
