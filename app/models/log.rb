class Log < ActiveRecord::Base
  def show
    puts('hi')
    Log.all.each do |l|
      
      @results = ''
      for i in 0..9
        question_id = "l.q"+i.to_s
        answer = "l.a"+i.to_s
        q = eval(question_id)
        a = eval(answer)
        r = Question.find(q).c.to_i
        puts(question_id)
        @results += 'question ' + q.to_s + 'answer ' + a.to_s + 'correct ' + r.to_s
      end
    end
    #Per question
    @q1 = 0
    @q2 = 0
    @q3 = 0
    @q4 = 0
    @q5 = 0
    @q6 = 0
    @q7 = 0
    @q8 = 0
    @q9 = 0
    @q10 = 0
    @q11 = 0
    
    #Per user
    
  end
end



