module ValueObjects
  class SongCreator
    attr_reader :creator_type, :display_name

    def initialize(creator_type:, display_name:)
      @creator_type = creator_type
      @display_name = display_name
    end
  end
end
