class Album < ApplicationRecord
  has_many :song_albums
  has_many :songs, through: :song_albums
  has_many :album_tracks
end