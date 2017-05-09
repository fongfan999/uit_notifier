require "facebook/messenger"
include Facebook::Messenger

class MessengerCommand
  AVAILABLE_COMMANDS = %w{ send_notification }
  REQUIRED_ARG_COMMANDS = %w{ send_notification }

  def initialize(sender, text)
    @sender = sender # {"id"=>"123456789"} 
    @user = User.find_by(sender_id: @sender["id"])
     
    if @words = text.try(:split) # ff activate
      @ff = @words[0] # ff
      @command = @words[1] # activate, whoami, ...
      @arg = @words[2] # token, index, ...
    end
  end

  def execute
    # Check user status
    not_active and return if @user.nil? && !FREE_COMMANDS.include?(@command)

    if @ff != "ff" || !AVAILABLE_COMMANDS.include?(@command)
      not_found
    elsif REQUIRED_ARG_COMMANDS.include?(@command) && @arg.nil?
      missing_arg
    else
      send(@command)
    end
  end

  def send_notification
    if notification = Notification.find_by_id(@arg)
      send_as_text("🔈🔈 #{notification.title}\n--------\n#{notification.content}\n#{notification.link}")
    end
  end

  private

  def send_as_text(text)
    # Truncate text if length is long
    text = (text.chars.first(600).join + " ...") if text.length > 600

    Bot.deliver({
      recipient: @sender,
      message: {
        text: text
      }
    }, access_token: ENV['ACCESS_TOKEN'])
  end
end
