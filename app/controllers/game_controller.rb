class GameController < ApplicationController
  def index
    all = Conversion.all
    
    n = 1 + rand(10)
    n1 = 25
    #n1 = 1 + rand(24)
    n2 = 1 + rand(24)
    
    #Questions whith CO2
    #@q = "How much is " + n.to_s + " " + Conversion.find(n1).unit + " in " + Conversion.find(n2).unit + "?"
    @q = "How many kilos of carbon dioxide are emitted by " +  n.to_s + " " + Conversion.find(n2).unit + "?"
  end
  
  
  def calculate
    
  end
  
end
