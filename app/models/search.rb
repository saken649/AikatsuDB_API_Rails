class Search < ApplicationRecord
  class << self
    def search(keyword)
      # TODO: 検索精度。。。もう少し工夫出来そう
      searches = Search.where('MATCH(keyword) AGAINST(:keyword IN BOOLEAN MODE)', { keyword: keyword }).limit(5)
      return [] if searches.blank?

      songs = songs(searches)
      songs.map { |song| ValueObjects::Song.new(song) }
    end

    private

    def songs(searches)
      conditions = searches.map { |s| "`#{s.related_table}`.`id` = '#{s.related_key}'" }.join(' OR ')

      # TODO: 並び順が出来れば関連順になって欲しい気はする
      Song.eager_load(
            [
              :song_singers,
              :song_creators,
              :albums,
              :singers,
              :creators,
              :characters,
              singers: :group,
              creators: :production
            ]
          )
          .where(conditions)
          .order('song_singers.display_order ASC')
          .order('song_creators.display_order ASC')
          .to_a
    end
  end
end