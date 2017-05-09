require 'mechanize'

class User < ApplicationRecord
  DAA_HOMEPAGE = 'https://daa.uit.edu.vn/'
  SCHEDULE_PAGE = 'https://daa.uit.edu.vn/sinhvien/thoikhoabieu'

  attr_encrypted :password, key: ENV["AES_KEY"]

  has_and_belongs_to_many :courses

  validates :username, presence: true, uniqueness: true
  validates :password, presence: true

  after_create :get_courses

  private
    def get_courses
      return if self.courses.any?

      agent = Mechanize.new
      page = agent.get(DAA_HOMEPAGE)
      agent.page.encoding = 'utf-8'

      daa_form = page.forms.last
      daa_form.field_with(name: 'name').value = username
      daa_form.field_with(name: 'pass').value = password
      agent.submit(daa_form)

      agent.get(SCHEDULE_PAGE)
        .search('.rowspan_data strong:first-child').each do |course|
        course = Course.find_or_create_by(name: course.text[/.+? /].delete(' '))
        course.users << self unless course.users.include?(self)
      end
    end
end
