class WelcomeController < ApplicationController

  def index
    @all = Conversion.all()
    
    #@all.map {|c| c.amount = kwh}
    
    @kwh = Conversion.find(5)
    
    @random = @all.sample
    #if @random.amount < 1 then
     # @random = @all.rand
    #end
  end

  def about
  end

  def api
  end
  
  private
  
  # kwh
  def kwh
    if !params[:kwh].nil?
      kwh = params[:kwh].to_i
      if kwh < 1 then kwh = 1 end
    else
      kwh = 1
    end
    return kwh
  end

end
