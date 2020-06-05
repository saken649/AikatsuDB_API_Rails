class SongCreator < ApplicationRecord
  belongs_to :song, primary_key: 'id', foreign_key: 'song_id'
  belongs_to :creator, primary_key: 'id', foreign_key: 'creator_id'

  module Delimiter
    KUTEN = '、'
  end
end