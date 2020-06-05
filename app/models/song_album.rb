class SongAlbum < ApplicationRecord
  belongs_to :song, primary_key: 'id', foreign_key: 'song_id'
  belongs_to :album, primary_key: 'id', foreign_key: 'album_id'
end