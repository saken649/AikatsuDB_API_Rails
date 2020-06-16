class CreatorsService
  class << self
    def list
      creators = Creator.list
      creators.map { |c| ValueObjects::Creator.new(c) }
    end
  end
end