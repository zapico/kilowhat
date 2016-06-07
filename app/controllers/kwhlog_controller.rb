class KwhlogController < ApplicationController
  def save
    kwhlog = Kwhlog.new
    kwhlog.content = params[:message]
    kwhlog.session = session[:session_id].to_s
    kwhlog.save
    render :nothing => true 
  end
  def show
  
  end
end
