module Api
  class SearchController < ApplicationController

    def reindex
      models = [Post, Author]
      models.each do |clz|
        clz.import force: true
      end
      redirect_to root_path, notice: "Eating up all that new data! #{models.map(&:name).to_sentence} have been reindexed."
    end

  end
end
