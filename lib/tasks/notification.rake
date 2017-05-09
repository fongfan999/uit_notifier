namespace :notifications do
  task refresh: :environment do
    `curl -s https://uit-notifier.herokuapp.com/ > /dev/null`
    Notification.fetch_new_notifications
  end

  task clean: :environment do
    `curl -s https://uit-notifier.herokuapp.com/ > /dev/null`
    Notification.clean
  end
end
