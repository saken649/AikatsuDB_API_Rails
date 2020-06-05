class Aitube < ApplicationRecord
  belongs_to :song, optional: true
end