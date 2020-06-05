module ValueObjects
  class Tag
    attr_reader :id, :tag, :tag_type

    module TagTypes
      SINGER = 'singer'
      CREATOR = 'creator'
    end

    def initialize(id:, tag:, tag_type:)
      @id = id
      @tag = tag
      @tag_type = tag_type
    end
  end
end
