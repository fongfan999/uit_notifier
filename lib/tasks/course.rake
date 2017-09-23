namespace :courses do
  task renew: :environment do
    `curl -s https://uit-notifier.herokuapp.com/ > /dev/null`
    Course.destroy_all
    User.all.each { |user| user.get_courses } # :find_each in the future
  end
end
