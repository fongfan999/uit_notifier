require 'open-uri'

class DaaCrawler
  GENERAL_NOTIFICATION_URL = 'https://daa.uit.edu.vn/thong-bao-chung'

  attr_reader :article

  def has_exam_schedule?
    @article = articles.find { |section| section.text.downcase.include?('lịch thi') }
  end

  def doc
    @_doc ||= Nokogiri::HTML(open(GENERAL_NOTIFICATION_URL, &:read))
  end

  def articles
    @_articles ||= doc.css('#block-system-main .clearfix')
  end
end
