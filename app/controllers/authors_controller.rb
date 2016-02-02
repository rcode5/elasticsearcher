class AuthorsController < ApplicationController
  before_action :set_author, only: [:show, :edit, :update, :destroy]

  include ES::Controller
  def index
    redirect_to root_path
  end

  def show
  end

  def new
    @author = Author.new
  end

  def edit
  end

  def create
    @author = Author.new(author_params)

    if @author.save
      redirect_to @author, notice: "I love new stuff! You just created #{@author.name}."
    else
      render :new
    end
  end

  def update
    if @author.update(author_params)
      redirect_to @author, notice: "I love keeping data current! You just updated #{@author.name}."
    else
      render :edit
    end
  end

  def destroy
    @author.destroy
    redirect_to root_path, notice: "I love taking out the trash!  #{@author.name} just got dumped."
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_author
      @author = Author.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def author_params
      params.require(:author).permit(:name, :hometown)
    end
end
