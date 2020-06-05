class Creator < ApplicationRecord
  has_many :song_creators
  has_many :songs, through: :song_creators

  belongs_to :production, optional: true
end