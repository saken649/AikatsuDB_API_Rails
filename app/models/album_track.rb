class AlbumTrack < ApplicationRecord
  belongs_to :album, optional: true
end