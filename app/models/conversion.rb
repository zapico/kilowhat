class Conversion < ActiveRecord::Base
  belongs_to :category
  attr_accessor :amount
  
  
  def amount=(co2)
    @amount = (co2/self.carbon).round
  end

  def amount
   @amount.to_i
  end
  
  def style(n)    
    case n
    when 1    #compare to 1
      puts "background-color: #686127;"
    when 2    #compare to 2
      puts "background-color: #eeeeee;"
    else
      puts "background-color: #cccccc;"
    end
  end
  
  private
  

end
