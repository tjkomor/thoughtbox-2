class Api::V1::LinksController < ApplicationController
  respond_to :json

  def update
    link = Link.find_by(id: params[:id])
    respond_with link.update_attributes(link_params)
  end

  private

  def link_params
    params.require(:link).permit(:url, :title, :read)
  end
end
