class SongCreator < ApplicationRecord
  belongs_to :song, primary_key: 'id', foreign_key: 'song_id'
  belongs_to :creator, primary_key: 'id', foreign_key: 'creator_id'

  module Delimiter
    KUTEN = '、'
  end

  module CreatorType
    LYRICS = 'lyrics'
    MUSIC = 'music'
    ARRANGEMENT = 'arrangement'
    REMIX = 'remix'
  end

  CREATOR_TYPES = [CreatorType::LYRICS, CreatorType::MUSIC, CreatorType::ARRANGEMENT, CreatorType::REMIX].freeze
end