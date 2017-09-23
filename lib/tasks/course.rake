namespace :courses do
  task renew: :environment do
    `curl -s https://uit-notifier.herokuapp.com/ > /dev/null`
    Course.delete_all
    User.all(&:get_courses) # :find_each in the future
  end
end
