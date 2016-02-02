class PostsController < ApplicationController
  before_action :set_post, only: [:show, :edit, :update, :destroy]

  include ES::Controller

  def index
    redirect_to root_path
  end

  def show
  end

  def new
    @post = Post.new
  end

  def edit
  end

  def create
    @post = Post.new(post_params)

    if @post.save
      redirect_to @post, notice: "Your site is growing! You just added &quot;#{@post.title}&quot;".html_safe
    else
      render :new
    end
  end

  def update
    if @post.update(post_params)
      redirect_to @post, notice: "Fixing typos is awesome. You just updated &quot;#{@post.title}&quot;".html_safe
    else
      render :edit
    end
  end

  def destroy
    @post.destroy
    redirect_to root_path, notice: "Taking out the trash!  &quot;#{@post.title} just got dumped.".html_safe
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_post
      @post = Post.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def post_params
      params.require(:post).permit(:title, :body)
    end
end
