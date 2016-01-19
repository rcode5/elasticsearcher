class PagesController < ApplicationController

  def root
    @posts = Post.all
    @authors = Author.all
  end

end
