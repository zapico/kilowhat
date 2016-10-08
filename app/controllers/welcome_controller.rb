class WelcomeController < ApplicationController

  def index
    @all = Conversion.order(:category_id)
    
    @all.map {|c| c.amount = 1}
    
    @co2 =   Conversion.find(5)
    
    @random = @all.sample
    while @random.amount <= 1 do
      @random = @all.sample
    end
  end

  def about
  end

  def api
  end
  
  private
  
  def co2
    if !params[:co2].nil?
      co2 = params[:co2].to_i
      if co2 < 1 then co2 = 1 end
    else
      co2 = 1
    end
    return co2
  end

end
