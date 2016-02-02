module Search
  class Result < SimpleDelegator
    def initialize(hit)
      @hit = process(hit)
      super(@hit)
    end

    private

    def process(hit)
      highlights = hit['highlight'] || {}
      highlights.each do |full_field, value|
        field1, field2 = full_field.split(".")
        hit["_source"][field1][field2] = value if [field1,field2,value].all?(&:present?)
      end
      OpenStruct.new(hit)
    end
  end
end
