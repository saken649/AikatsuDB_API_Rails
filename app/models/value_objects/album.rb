module ValueObjects
  class Album
    attr_reader :id,
                :title,
                :sub_title,
                :sold_date,
                :image_path,
                :disc_number,
                :disc_total,
                :track_number,
                :track_total

    def initialize(
      id:,
      title:,
      sub_title:,
      sold_date:,
      image_path:,
      disc_number:,
      disc_total:,
      track_number:,
      track_total:
    )
      @id = id
      @title = title
      @sub_title = sub_title
      @sold_date = sold_date
      @image_path = "#{::ImageUtil::image_host}/#{image_path}"
      @disc_number = disc_number
      @disc_total = disc_total
      @track_number = track_number
      @track_total = track_total
    end
  end
end
