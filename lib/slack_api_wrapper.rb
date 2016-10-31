require 'httparty'
# require 'channel' - make sure channel has name that is being called via lib

class Slack_Api_Wrapper
  TOKEN = ENV["SLACK_TOKEN"]
  BASE_URL = "https://slack.com/api/"


  def self.list_channels
    url = BASE_URL + "channels.list?token=#{TOKEN}"

    response = HTTParty.get(url)

    my_channels = []
    response["channels"].each do |channel|
      id = channel["id"]
      name = channel["name"]
      my_channels << Slack_Channel.new(name, id)
    end
    my_channels
  end

  # def self.send_message(channel, msg) #, icon_emoji
  #   url = BASE_URL + "chat.postMessage?token=#{TOKEN}" + "&text=#{msg}" + "&channel=#{channel}"
  #   # +
  #   # "&icon_emoji=#{icon_emoji}"
  #
  #   response = HTTParty.get(url)
  #
  # end

  def self.sendmsg(channel, msg, token = nil)
    token = TOKEN if token == nil
    puts "Sending message to channel #{channel}: #{msg}"

    url = BASE_URL + "chat.postMessage?" + "token=#{token}"

    data = HTTParty.post(url,
    body:  {
      "text" => "#{msg}",
      "channel" => "#{channel}",
      "username" => "Mr. Botler",
      "icon_emoji" => ":shaved_ice:",
      "as_user" => "false"
    },
    :headers => { 'Content-Type' => 'application/x-www-form-urlencoded' })
  end

end
