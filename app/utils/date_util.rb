class DateUtil
  FORMAT_YMD = '%Y/%m/%d'

  def self.ymd(date)
    date.strftime(FORMAT_YMD)
  end
end