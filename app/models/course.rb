class Course < ApplicationRecord
  has_and_belongs_to_many :users

  def self.filter_by_notification(notification)
    Course.find_by_id(
      Course.pluck(:id, :name)
        .find { |c| notification.title =~ /\(#{c[1]}\)/ }.try(:first)
    )
  end
end
