class CreatorsService
  class << self
    def list
      creators = Creator.list
      creators.map { |c| ValueObjects::Creator.new(c) }
    end

    def name(creator_id)
      creator = Creator.by_id(creator_id)
      ValueObjects::Creator.new(creator)
    end
  end
end