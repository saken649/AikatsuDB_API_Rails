module ValueObjects
  class SingerAbout
    attr_reader :singer_id, :name, :name_kana, :is_current

    def initialize(singer_id:, name:, name_kana:, display_name:, is_current:)
      @singer_id = singer_id
      @name = "#{display_name} (#{name})"
      @name_kana = name_kana
      @is_current = is_current == 1 ? true : false
    end
  end
end
