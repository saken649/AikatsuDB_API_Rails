class ImageUtil
  class << self
    def with_host(path)
      "#{image_host}/#{path}"
    end

    private

    def image_host
      ENV['IMAGE_HOST'] || 'http://localhost:3002'
    end
  end
end