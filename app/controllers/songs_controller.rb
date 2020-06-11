class SongsController < ApplicationController
  # 楽曲リスト
  def list
    r = SongService.list(params[:song_id])
    render json: r, status: r.present? ? :ok : :not_found
  end

  def detail
    render json: SongService.detail(params[:song_id])
  end

  def search
    render json: [], status: :not_found if params[:keyword].nil?

    render json: Search.search(params[:keyword])
  end
end