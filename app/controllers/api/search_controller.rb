module Api
  class SearchController < ApplicationController

    def reindex
      models = [Post, Author, Ngram::Author]
      models.each do |clz|
        clz.import force: true
      end
      redirect_to root_path, notice: "Reindexed #{models.map(&:name).join ', '}"
    end
  end

end
