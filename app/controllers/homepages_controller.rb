#require "slack_api_wrapper"
#require "channel"



class HomepagesController < ApplicationController
  def index
    @data = Slack_Api_Wrapper.list_channels
  end

  def create
    response = Slack_Api_Wrapper.sendmsg(params[:channel], params[:message])

    if response["ok"]
      flash[:notice] = "Message sent successfully to #{params[:channel_name]}"
    else
      flash[:notice] = "Message failed to be sent to #{params[:channel_name]}"
    end
    redirect_to root_path
  end

  def new
    @channel = params[:name]
    @channel_id = params[:id]
  end
end
