class GameController < ApplicationController

  def index
    # Select random unit and initialize content
    # questions = Question.limit(10).order("RAND()")
   questions = Question.limit(10).order("Random()")
    @count = 0
    @correct = 0
    for i in 0..9
        session[":q"+i.to_s] = questions[i].id
        session[":a"+i.to_s] = false
    end
    session[:test] = params[:test]
    @q = questions[0]
    session[:count] = @count
  end 
  
  def next
    @count = session[:count].to_i + 1
    session[:count] = @count
    answer = params[:a]
    session[":a"+(@count -1).to_s] = answer
    if (@count != 10)
      @q = Question.find(session[":q"+@count.to_s].to_i)
      render "next", layout: "game"
    else
      redirect_to "/results"
    end
  end  
   
  
  def results
    @correct = 0
    for i in 0..9
        puts("q" + i.to_s + " " + session[":q"+i.to_s].to_s)
    end
    # Prepare answers to show
    @q1 = ""
    for i in 0..9
      question_id = session[":q"+i.to_s].to_i
      answer = session[":a"+i.to_s].to_i
      correct = Question.find(question_id).c.to_i
      query1 = "Question.find(#{question_id}).a" + answer.to_s
      if ( answer == correct ) then 
        @correct+=1 
        @q1 += "<div class='answer_frame'><div class='correct'></div><div class='answer'><b>" + Question.find(question_id).q + "</b></br><green> Correct answer! </green>  " + eval(query1) + "</div></div>"
      else 
        query2 = "Question.find(#{question_id}).a" + Question.find(question_id).c.to_s 
        @q1 += "<div class='answer_frame'><div class='wrong'></div><div class='answer'><b>" + Question.find(question_id).q + "</b></br><red> You answered  </red>" + eval(query1) + ". The correct answer was: " + eval(query2) + "</div></div>"
      end
    end
    
    # Save answers in db
    # Agh! I did not manage to fix it with a loop :(
    result = Log.new
    result.q1 = session[":q0"].to_i
    result.q2 = session[":q1"].to_i
    result.q3 = session[":q2"].to_i
    result.q4 = session[":q3"].to_i
    result.q5 = session[":q4"].to_i
    result.q6 = session[":q5"].to_i
    result.q7 = session[":q6"].to_i
    result.q8 = session[":q7"].to_i
    result.q9 = session[":q8"].to_i
    result.q10 = session[":q9"].to_i
    result.a1 = session[":a0"].to_i
    result.a2 = session[":a1"].to_i
    result.a3 = session[":a2"].to_i
    result.a4 = session[":a3"].to_i
    result.a5 = session[":a4"].to_i
    result.a6 = session[":a5"].to_i
    result.a7 = session[":a6"].to_i
    result.a8 = session[":a7"].to_i
    result.a9 = session[":a8"].to_i
    result.a10 = session[":a9"].to_i
    result.test_name = session[:test]
    result.session = session[:session_id].to_s
    result.save
    
    for i in 0..9
        session[":q"+i.to_s] = 0
        session[":a"+i.to_s] = false
    end
    
  end
  
end

