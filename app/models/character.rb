class Character < ApplicationRecord
  has_many :song_characters
  has_many :songs, through: :song_characters

  has_many :character_singers
  has_many :singers, through: :character_singers

  # キャラクター名一覧
  # @return [Array<String>]
  def self.name_list
    Character.select('CONCAT(name_family, name_first) AS name')
             .order(:order)
             .map(&:name)
  end
end