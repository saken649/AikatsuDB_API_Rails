module ValueObjects
  class AlbumSong
    attr_reader :song_id,
                :title,
                :sub_title,
                :singer,
                :track_number,
                :disc_number

    def initialize(song:, track_number:, disc_number:)
      @track_number = track_number
      @disc_number = disc_number

      @song_id = song.id
      @title = song._title
      @sub_title = song.sub_title

      singers = ValueObjects::Singers.new(song)
      @singer = singers.singers_with_group
    end
  end
end
