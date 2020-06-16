module ValueObjects
  class Creator
    attr_reader :creator_id, :name, :name_kana, :creator_types

    def initialize(creator)
      @creator_id = creator.id
      @name = name(creator)
      @name_kana = creator.artist_name_kana.presence || "#{creator.name_family_kana}#{creator.name_first_kana}"
      @creator_types = creator_types(creator)
    end

    private

    def name(creator)
      name = creator.artist_name.presence || "#{creator.name_family}#{creator.name_first}"
      if creator.production.present?
        name += " (#{creator.production.name})"
      end
      name
    end

    def creator_types(creator)
      creator_types = []
      ::SongCreator::CREATOR_TYPES.each do |creator_type|
        creator_types << creator_type if creator.song_creators.any? { |sc| sc.creator_type == creator_type }
      end
      creator_types
    end
  end
end
