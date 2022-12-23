class MessagesController < ApplicationController
  def create
    params_message = paeams.require(:message).premit(:message)
    @message = Message.new(params_message)
    if @message.save
      render @message 
    end
  end
end
