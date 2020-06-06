class SongService
  class << self
    # 楽曲リスト
    # @param [integer] song_id
    # @return [Array<ValueObjects::Song>]
    def songs(song_id)
      song_list = Song.list(song_id)
      return [] if song_list.blank?

      song_ids_uniq = song_list.map { |s| s.song_id }.uniq
      song_ids_uniq.map do |song_id_uniq|
        # singer ごとになってる Song を取得
        song = song_list.select { |s| s.song_id == song_id_uniq }
        singers = singers_from_song(song)
        ValueObjects::Song.new(
          song_id: song.first.song_id,
          parent_song_id: song.first.parent_song_id,
          title: song.first.title,
          sub_title: song.first.sub_title,
          singer: singers.singers_with_group,
          image_path: song.first.image_path
        )
      end
    end

    def detail(song_id)
      song = Song.song_with_related_records_by_id(song_id)
      return {} if song.blank?

      singers = singers(song)
      creators = ValueObjects::SongCreators.new(song_creators(song))

      {
        song_id: song.id,
        title: title(song),
        sub_title: song.sub_title,
        aitube_url: song.aitubes.map(&:youtube_id),
        singer: singers.singers_with_group,
        creators: {
          lyrics: creators.lyrics,
          music: creators.music,
          arrangement: creators.arrangement,
          remix: creators.remix,
          all: creators.all
        }
      }
    end

    private

    # @param [Song::list] song
    # @return [Singers]
    def singers_from_song(song)
      singers = ValueObjects::Singers.new
      song.each do |s|
        singer = ValueObjects::Singer.new(
          singer_id: s.singer_id,
          display_name: s.display_name,
          group_name: s.group_name,
          display_order: s.display_order,
          group_displayable: s.group_displayable,
          delimiter_to_next: s.delimiter_to_next
        )
        singers.push(singer)
      end
      singers
    end

    # @param [ActiveRecord::Song] song
    # @return [Singers]
    def singers(song)
      singers = ValueObjects::Singers.new

      song.song_singers.each do |song_singer|
        singer = ValueObjects::Singer.new(
          singer_id: song_singer.singer_id,
          display_name: song_singer.singer.display_name,
          group_name: song_singer.singer.group.name,
          display_order: song_singer.display_order,
          group_displayable: song_singer.group_displayable,
          delimiter_to_next: song_singer.delimiter_to_next
        )
        singers.push(singer)
      end
      singers
    end

    def song_creators(song)
      return song.song_creators if song.songs_parent.nil?
      # 直接 concat すると UPDATE が走るので一度 to_a
      song.song_creators.to_a.concat(song.songs_parent.song_creators)
    end

    def title(song)
      return song.title if song.songs_parent.nil?
      song.songs_parent.title
    end
  end
end