module ValueObjects
  class Singers
    def initialize(song)
      @singers = song.song_singers.map do |song_singer|
        ValueObjects::Singer.new(
          singer_id: song_singer.singer_id,
          display_name: song_singer.singer.display_name,
          group_name: song_singer.singer.group.name,
          display_order: song_singer.display_order,
          group_displayable: song_singer.group_displayable,
          delimiter_to_next: song_singer.delimiter_to_next
        )
      end
    end

    # display_name を連結して「わか・ふうり・すなお from STAR☆ANIS」表記を生成するとこ
    def singers_with_group
      singers_with_group = ''
      @singers.each do |s|
        base = s.display_name
        base += " from #{s.group_name}" if s.group_displayable
        base += delimiter(s.delimiter_to_next)

        singers_with_group += base
      end
      singers_with_group
    end

    private

    def delimiter(delimiter_to_next)
      return '' if delimiter_to_next.blank?
      delimiter_to_next == SongSinger::Delimiter::DOT ? delimiter_to_next : " #{delimiter_to_next} "
    end
  end
end