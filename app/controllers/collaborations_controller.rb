class CollaborationsController < ApplicationController
  before_filter :find_wiki

  def new
    @collaboration = Collaboration.new
  end

  def create
    @wiki.collaborations.delete_all
    @collaborations = []
    params[:collaboration][:user_id].each do |user_id|
      @collaborations << Collaboration.create(user_id: user_id, wiki_id: @wiki.id)
    end
    # loop through the params[:collaboration][:user_id].each
    # for each collaboration, create a new Collaboration object with the user_id and the @wiki_id (Collaboration.create(user_id: whatever, wiki_id: @wiki.id))
    # redirect to whereever you want to go
    redirect_to @wiki
  end  
    

  private 

  def find_wiki
    @wiki = Wiki.find(params[:wiki_id])
  end
end
