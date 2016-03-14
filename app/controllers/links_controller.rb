class LinksController < ApplicationController
  before_action :check_current_user

  def index
    @links = current_user.links
  end

  def create
    link = Link.new(link_params)
    if link.save
      current_user.links << link
      flash[:notice] = ["Link created!"]
      redirect_to links_path
    else
      flash[:errors] = link.errors.full_messages
      redirect_to links_path
    end
  end

  def edit
    @link = Link.find(params[:id])
  end

  def update
    @link = Link.find(params[:id])
    if @link.update(link_params)
      flash[:notice] = "Successfully updated #{@link.title}"
      redirect_to links_path
    else
      flash[:error] = "Must submit a valid URL"
      render :edit
    end
  end

  def destroy
    @link = Link.find(params[:id]).destroy
    redirect_to links_path
  end


  private

  def link_params
    params.require(:link).permit(:title, :url)
  end
end
