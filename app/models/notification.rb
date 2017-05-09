require 'mechanize'

class Notification < ApplicationRecord
  OFF_CLASS_PAGE = 'https://daa.uit.edu.vn/thong-bao-nghi-bu'

  def self.initialize_with(notification_params)
    Notification.create_with(notification_params)
      .find_or_initialize_by(link: notification_params[:link])
  end

  def self.fetch_new_notifications
    agent = Mechanize.new
    (0..9).each do |page|
      agent.get("#{OFF_CLASS_PAGE}?page=#{page}")
        .search('.views-row')
        .each do |node|

        title_with_link = node.at('h2 a')
        notification_params = {
          title: title_with_link.text,
          content: node.at('.content').text.strip,
          link: "https://daa.uit.edu.vn#{title_with_link.attr('href')}"
        }
        notification = Notification.initialize_with(notification_params)

        if notification.send(:should_notify_to_user?)
          notification.save(validate: false)

          if course = Course.filter_by_notification(notification)
            course.users.each do |user|
              # Notify to FB Messenger users only
              next unless user.sender_id

              MessengerCommand.new({"id" => user.sender_id},
                "ff send_notification #{notification.id}").delay.execute
            end
          end
        end
      end
    end
  end

  private
    def should_notify_to_user?
      new_record? && Time.zone.parse(title).to_date >= Time.zone.today
    end
end
