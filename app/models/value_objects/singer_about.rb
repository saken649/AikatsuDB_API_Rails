module ValueObjects
  class SingerAbout
    attr_reader :singer_id,
                :name,
                :is_current

    def initialize(singer_id:, name:, display_name:, is_current:)
      @singer_id = singer_id
      @name = "#{display_name} (#{name})"
      @is_current = is_current == 1 ? true : false
    end
  end
end
