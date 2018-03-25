namespace :utils do
  task check_new_es: :environment do
    `curl -s https://uit-notifier.herokuapp.com/ > /dev/null`

    if DaaCrawler.new.has_exam_schedule?
      command = MessengerCommand.new('id' => ENV['ADMIN_SENDER_ID'])
      command.send(:send_as_text, 'There was a new exam schedule !!')
    end
  end
end
