class SongsController < ApplicationController
  # 楽曲リスト
  def list
    r = SongService.songs(params[:song_id])
    render json: r, status: r.present? ? :ok : :not_found
  end

  def detail
    render json: SongService.detail(params[:song_id])
  end
end