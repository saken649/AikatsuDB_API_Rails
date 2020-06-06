class ImageUtil
  class << self
    def image_host
      ENV['IMAGE_HOST'] || 'http://localhost:3002'
    end
  end
end