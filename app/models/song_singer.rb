class SongSinger < ApplicationRecord
  belongs_to :song, primary_key: 'id', foreign_key: 'song_id'
  belongs_to :singer, primary_key: 'id', foreign_key: 'singer_id'

  module Delimiter
    NONE = nil
    DOT = '・'
    AND = '&'
    SLASH = '/'
  end
end