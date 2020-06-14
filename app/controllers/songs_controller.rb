class SongsController < ApplicationController
  # TODO: status もう少し整える

  # 楽曲リスト
  def list
    r = SongService.list(id: nil, type: SongService::SearchType::ALL)
    render json: r, status: r.present? ? :ok : :not_found
  end

  # 楽曲バージョンリスト
  def list_variation
    r = SongService.list(id: params[:song_id], type: SongService::SearchType::SONG)
    render json: r, status: r.present? ? :ok : :not_found
  end

  # 楽曲リスト(歌唱担当)
  def list_by_singer
    r = SongService.list(id: params[:singer_id], type: SongService::SearchType::SINGER)
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