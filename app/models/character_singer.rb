class CharacterSinger < ApplicationRecord
  belongs_to :character, primary_key: 'id', foreign_key: 'character_id'
  belongs_to :singer, primary_key: 'id', foreign_key: 'singer_id'
end