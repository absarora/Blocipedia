class WikisController < ApplicationController
  def index
    @wikis = Wiki.all
  end

  def new
    @wiki = Wiki.new
    @wiki = current_user.wikis.build(params[:wiki])
    authorize! :create, @wiki, message: "You need to be signed up to create wikis."
  end

  def show
    @wiki = Wiki.find(params[:id])
    @collaboration = Collaboration.new
    @collaboration = current_user.collaborations.build(params[:collaboration])

  end

  def edit
    @wiki = Wiki.find(params[:id])
    authorize! :update, @wiki, message: "You need to own the wiki to update it."
  end

  def create
    @wiki = current_user.wikis.build(params[:wiki])
    authorize! :create, @wiki
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
