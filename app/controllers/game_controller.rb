class GameController < ApplicationController
  def random
    bool = rand(0..2)
    
    if (bool==0) then
      # Case 1: question about production
      
      # Select random unit and initialize content
      all = Conversion.where("category_id == 1 AND id != 5")
      count = all.count()
      rnd = rand(0..count-1)
      unit = all[rnd].unit
      amount = 1 + rand(50)
      kwh = all[rnd].carbon*amount
      kwh = kwh.round(0)
      
      # Position and generate other answers
      @correct = rand(1..3)
      case @correct
      when 1
        alt1 = amount
        alt2 = amount+rand(0..amount)
        alt3 = amount+rand(alt2..alt2*2)
      when 2
        alt1 = amount-rand(0..amount-1)
        alt2 = amount
        alt3 = amount+rand(0..amount*2)
      when 3
        alt1 = amount-rand(amount/2..amount-1)
        alt2 = amount-rand(0..amount/2)
        alt3 = amount
      end  
      
      # Generate question
      @q = "If you need to produce " +  kwh.to_s + " kwh, how many " + unit +  "?"
        
      # Add values to possible answers
      @a1 =  alt1.to_s
      @a2 =  alt2.to_s
      @a3 =  alt3.to_s
      
        
    end
    if (bool==1) then
    
      # Case 2: question about consumption
      
      # Select random unit and initialize content
      all = Conversion.where("category_id != 1")
      count = all.count()
      rnd = rand(0..count-1)
      unit = all[rnd].unit
      amount = 1 + rand(10)
      kwh = all[rnd].carbon*amount
      kwh = BigDecimal.new(kwh,4)    
      
      # Position and generate other answers
      @correct = rand(1..3)
      case @correct
      when 1
        alt1 = kwh
        alt2 = kwh*10
        alt3 = kwh*100
      when 2
        alt1 = kwh/10
        alt2 = kwh
        alt3 = kwh*10
      when 3
        alt1 = kwh/100
        alt2 = kwh/10
        alt3 = kwh
      end
      
      # Generate question
      @q = "How many kilowatthour of electricity do you need for " +  amount.to_s + " " + unit + "?"
      
      # Add values to possible answers
      @a1 =  alt1.to_s
      @a2 =  alt2.to_s
      @a3 =  alt3.to_s
    
      
    #end if  
    end  
    

    # Case 3: compare different thigns
    if (bool==2) then
      
      # Select random unit and initialize content
      all = Conversion.where("category_id != 1")
      count = all.count()
      rnd = rand(0..count-1)
      unit = all[rnd].unit
      amount = 1 + rand(10)
      kwh = all[rnd].carbon*amount
      kwh = BigDecimal.new(kwh,4)    
      
      # Position and generate other answers
      @correct = rand(1..3)
    
    end
    
  end

  def index
    # Select random unit and initialize content
    questions = Question.limit(5).order("Random()")
    @count = 0
    @correct = 0
    session[:q1] = questions[0].id
    session[:q2] = questions[1].id
    session[:q3] = questions[2].id
    session[:q4] = questions[3].id
    session[:q5] = questions[4].id
    session[:a1] = false
    session[:a2] = false
    session[:a3] = false
    session[:a4] = false
    session[:a5] = false
    @q = questions[0]
    session[:count] = @count
  end 
  
  def next
    @count = session[:count].to_i + 1
    session[:count] = @count
    answer = params[:a]
    if (@count != 5)
    case @count
    when 1
      @q = Question.find(session[:q2].to_i)
      session[:a1] = answer
    when 2
      @q = Question.find(session[:q3].to_i)
      session[:a2] = answer
    when 3
      @q = Question.find(session[:q4].to_i)
      session[:a3] = answer
    when 4
      @q = Question.find(session[:q5].to_i)
      session[:a4] = answer
    end
    render "next", layout: "game"
  else
    session[:a5] = answer
    redirect_to "/results"
  end
  end  
   
  
  def results
    # Code may be poetry, but sometimes I just need things to work... ;)
    @q2 = Question.find(session[:q2].to_i).q
    @q3 = Question.find(session[:q3].to_i).q
    @q4 = Question.find(session[:q4].to_i).q
    @q5 = Question.find(session[:q5].to_i).q
    @a1 = session[:a1].to_i
    @a2 = session[:a2].to_i
    @a3 = session[:a3].to_i
    @a4 = session[:a4].to_i
    @a5 = session[:a5].to_i
    @c1 = Question.find(session[:q1].to_i).c.to_i
    @c2 = Question.find(session[:q2].to_i).c.to_i
    @c3 = Question.find(session[:q3].to_i).c.to_i
    @c4 = Question.find(session[:q4].to_i).c.to_i
    @c5 = Question.find(session[:q5].to_i).c.to_i
    @correct = 0
    if (@a1 == @c1) then 
      @correct+=1 
      query1 = "Question.find(session[:q1].to_i).a" + @a1.to_s
      @q1 = Question.find(session[:q1].to_i).q + " Correct answer! " + eval(query1)
    else
      query1 = "Question.find(session[:q1].to_i).a" + @a1.to_s
      query2 = "Question.find(session[:q1].to_i).a" + @c1.to_s
      @q1 = Question.find(session[:q1].to_i).q + " You answered " + eval(query1) + ". The correct answer was: " + eval(query2)
    end
    if (@a2 == @c2) then 
      @correct+=1 
      query1 = "Question.find(session[:q2].to_i).a" + @a2.to_s
      @q2 = Question.find(session[:q2].to_i).q + " Correct answer! " + eval(query1)
    else
      query1 = "Question.find(session[:q2].to_i).a" + @a2.to_s
      query2 = "Question.find(session[:q2].to_i).a" + @c2.to_s
      @q2 = Question.find(session[:q2].to_i).q + " You answered " + eval(query1) + ". The correct answer was: " + eval(query2)
    end
    if (@a3 == @c3) then 
      @correct+=1
      query1 = "Question.find(session[:q3].to_i).a" + @a3.to_s
      @q3 = Question.find(session[:q3].to_i).q + " Correct answer! " + eval(query1) 
    else
      query1 = "Question.find(session[:q3].to_i).a" + @a3.to_s
      query2 = "Question.find(session[:q3].to_i).a" + @c3.to_s
      @q3 = Question.find(session[:q3].to_i).q + " You answered " + eval(query1) + ". The correct answer was: " + eval(query2)
    end
    if (@a4 == @c4) then []
      @correct+=1 
      query1 = "Question.find(session[:q4].to_i).a" + @a4.to_s
      @q4 = Question.find(session[:q4].to_i).q + " Correct answer! " + eval(query1)
    else
      query1 = "Question.find(session[:q4].to_i).a" + @a4.to_s
      query2 = "Question.find(session[:q4].to_i).a" + @c4.to_s
      @q4 = Question.find(session[:q4].to_i).q + " You answered " + eval(query1) + ". The correct answer was: " + eval(query2)
    end
    if (@a5 == @c5) then 
      @correct+=1
      query1 = "Question.find(session[:q5].to_i).a" + @a5.to_s
      @q5 = Question.find(session[:q5].to_i).q + " Correct answer! " + eval(query1) 
    else
      query1 = "Question.find(session[:q5].to_i).a" + @a5.to_s
      query2 = "Question.find(session[:q5].to_i).a" + @c5.to_s
      @q5 = Question.find(session[:q5].to_i).q + " You answered " + eval(query1) + ". The correct answer was: " + eval(query2)
    end
  end
  
end

