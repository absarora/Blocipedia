class WikisController < ApplicationController
  def index
    @wikis = Wiki.all
  end

  def new
    @wiki = Wiki.new
    authorize! :create, @wiki, message: "You need to be an admin to do that."
  end

  def show
    @wiki = Wiki.find(params[:id])
    @pages = @wiki.pages
  end

  def edit
    @wiki = Wiki.find(params[:id])
    authorize! :update, @wiki, message: "You need to be an admin to do that."
  end

  def create
    @wiki = Wiki.new(params[:wiki])
    authorize! :create, @wiki, message: "You need to be an admin to do that."
    if @wiki.save
      redirect_to @wiki, notice: "Wiki was saved successfully."
    else
      flash[:error] = "Error creating wiki. Please try again."
      render :new
    end
  end

  def update
    @wiki = Wiki.find(params[:id])
    authorize! :update, @wiki, message: "You need to own the wiki to update it."
    if @wiki.update_attributes(params[:wiki])
      redirect_to @wiki, notice: "Wiki was saved successfully."
    else
      flash[:error] = "Error saving wiki. Please try again."
      render :edit
    end
  end
end
