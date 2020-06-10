class AlbumsController < ApplicationController
  def detail
    render json: AlbumService.detail(params[:album_id])
  end
end