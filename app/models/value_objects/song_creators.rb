module ValueObjects
  class SongCreators
    ATTRS = [:all, :lyrics, :music, :arrangement, :remix]
    attr_reader(*ATTRS)

    module CreatorType
      LYRICS = 'lyrics'
      MUSIC = 'music'
      ARRANGEMENT = 'arrangement'
      REMIX = 'remix'
    end

    def initialize(song_creators)
      @all = []

      ATTRS.each do |attr|
        next if attr == :all

        attr_str = attr.to_s
        song_creators_per_type = song_creators.select { |sc| sc.creator_type == attr_str }
        next if song_creators_per_type.blank?

        song_creator = ValueObjects::SongCreator.new(
          creator_type: song_creators_per_type.first.creator_type,
          display_name: display_name(song_creators_per_type)
        )
        self.instance_variable_set("@#{attr_str}", song_creator)

        song_creators_per_type.each do |scpt|
          @all << ValueObjects::SongCreator.new(
            creator_type: scpt.creator_type,
            display_name: display_name([scpt], is_single: true)
          )
        end
      end
    end

    private

    # 石濱翔 (MONACA) とか 片山将太、藤末樹 表記を作るとこ
    def display_name(song_creators, is_single: false)
      display_name = ''
      song_creators.each do |song_creator|
        creator = song_creator.creator

        if creator.artist_name.present?
          display_name += "#{creator.artist_name}"
        else
          display_name += "#{creator.name_family}#{creator.name_first}"
        end

        if creator.production_id.present? && (song_creator.production_displayable == 1 || is_single)
          display_name += " (#{creator.production.name})"
        end

        if song_creator.delimiter_to_next.present? && !is_single
          display_name += song_creator.delimiter_to_next == ::SongCreator::Delimiter::KUTEN ? song_creator.delimiter_to_next : " #{song_creator.delimiter_to_next} "
        end
      end
      display_name
    end
  end
end
