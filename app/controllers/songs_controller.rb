class SongsController < ApplicationController
  # TODO: status もう少し整える

  # 楽曲リスト
  def list
    render json: SongService.list(id: nil, type: SongService::SearchType::ALL)
  end

  # 楽曲バージョンリスト
  def list_variation
    render json: SongService.list(id: params[:song_id], type: SongService::SearchType::SONG)
  end

  # 楽曲リスト(歌唱担当)
  def list_by_singer
    render json: SongService.list(id: params[:singer_id], type: SongService::SearchType::SINGER)
  end

  def detail
    render json: SongService.detail(params[:song_id])
  end

  def search
    render json: [], status: :not_found if params[:keyword].nil?

    render json: Search.search(params[:keyword])
  end
end