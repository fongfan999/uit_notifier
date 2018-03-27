namespace :utils do
  task check_new_es: :environment do
    `curl -s https://uit-notifier.herokuapp.com/ > /dev/null`

    bot = DaaCrawler.new
    if bot.has_exam_schedule?
      command = MessengerCommand.new('id' => ENV['ADMIN_SENDER_ID'])
      command.send(:send_as_text, bot.article.text)
    end
  end
end
