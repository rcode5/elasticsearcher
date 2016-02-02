module Search
  class Result

    attr_reader :type, :score, :source

    def initialize(hit)
      @type = hit['_type']
      @score = hit['_score']
      @source = (hit['_source'] || {}).with_indifferent_access
      @highlight = (hit['highlight'] || {}).with_indifferent_access

      @source.keys.each do |meth|
        if !self.respond_to? meth
          (class << self; self; end).class_eval do
            define_method meth do |*args|
              field = meth.to_s.split('.')
              @highlight.dig( *field )&.join || @source.dig( *field )
            end
          end
        end
      end
    end

  end
end
