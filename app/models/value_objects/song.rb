module ValueObjects
  class Song
    attr_reader :song_id,
                :parent_song_id,
                :title,
                :sub_title,
                :singer,
                :image_path

    def initialize(
      song_id:,
      parent_song_id:,
      title:,
      sub_title:,
      singer:,
      image_path:
    )
      @song_id = song_id
      @parent_song_id = parent_song_id
      @title = title
      @sub_title = sub_title
      @singer = singer
      @image_path = "#{image_host}/#{image_path}"
    end

    private

    def image_host
      ENV['IMAGE_HOST'] || 'http://localhost:3002'
    end
  end
end
