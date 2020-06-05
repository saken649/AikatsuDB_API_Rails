class SongCharacter < ApplicationRecord
  belongs_to :song, primary_key: 'id', foreign_key: 'song_id'
  belongs_to :character, primary_key: 'id', foreign_key: 'character_id'
end