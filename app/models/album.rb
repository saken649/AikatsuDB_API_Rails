class Album < ApplicationRecord
  has_many :song_albums
  has_many :songs, through: :song_albums
  has_many :album_tracks

  class << self
    def detail(album_id)
      Album.includes(
             [
               :album_tracks,
               :song_albums,
               :songs,
               songs: [
                 :singers,
                 # parent のみ結合、そこから先はもう N+1 になっても諦める
                 :songs_parent
               ],
             ]
           )
           .order('album_tracks.disc_number ASC')
           .order('song_albums.disc_number ASC')
           .order('song_albums.track_number ASC')
           .order('song_singers.display_order ASC')
           .find_by(albums: { id: album_id })
    end
  end
end