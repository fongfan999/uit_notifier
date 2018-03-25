class DaaCrawler
  GENERAL_NOTIFICATION_URL = 'https://daa.uit.edu.vn/thong-bao-chung'

  def has_exam_schedule?
    doc.any? { |title| title.text.downcase.include?('lịch thi') }
  end

  def doc
    @_doc ||= Nokogiri::HTML(open(url, &:read))
  end

  def titles
    @_titles ||= doc.css('h2 a')
  end
end
