Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  # get '/teapot', to: 'teapots#index'

  # Singers
  get '/singers_name_list', to: 'singers#name_list'
  get '/singers', to: 'singers#list'

  # Characters
  get '/characters_name_list', to: 'characters#name_list'

  # Songs
  get '/songs/by_singer/:singer_id', to: 'songs#list_by_singer' # 楽曲リスト(歌唱担当)
  get '/songs/:song_id', to: 'songs#list_variation' # 楽曲バージョンリスト
  get '/songs', to: 'songs#list' # 楽曲リスト
  get '/song_detail/:song_id', to: 'songs#detail' # 楽曲詳細
  get '/song/search', to: 'songs#search'

  # Albums
  get '/album_detail/:album_id', to: 'albums#detail' # アルバム詳細
end
