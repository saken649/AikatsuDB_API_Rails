module ValueObjects
  class Song
    attr_reader :song_id,
                :parent_song_id,
                :title,
                :sub_title,
                :singer,
                :image_path

    def initialize(song)
      singers = ValueObjects::Singers.new(song)
      image_path = song.song_albums.first.album.image_path

      @song_id = song.id
      @parent_song_id = song.parent_song_id
      @title = song._title
      @sub_title = song.sub_title
      @singer = singers.singers_with_group
      @image_path = "#{::ImageUtil::image_host}/#{image_path}"
    end
  end
end
