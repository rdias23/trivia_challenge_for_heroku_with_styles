class QuizController < ApplicationController

  def index
  end

  def start
	 if user_signed_in?
             @user = current_user
             reset_session
             sign_in(@user, :bypass => true)
         else
             reset_session
         end

	 total = params[:number].to_i
         all = Question.where("question_type = 'alcolyte'").map {|x| x.id}
	 session[:questions] = all.sort_by{rand}[0..(total-1)]
	 
	 session[:total]   = total
	 session[:current] = 0
	 session[:correct] = 0
	 
	 redirect_to :action => "question"
  end

  def question
 	 @current = session[:current]
	 @total   = session[:total]
	 
	 if @current >= @total
		redirect_to :action => "end"
		return
	 end
	 
	 @question = Question.find(session[:questions][@current])
	 @choices = @question.choices.sort_by{rand}
	 
	 session[:question] = @question
	 session[:choices] = @choices 
  end

  def answer
         @current = session[:current]
	 @total   = session[:total]
	 
	 choiceid = params[:choice]
	 
	 @question = session[:question]
	 @choices  = session[:choices]





	 @used_id_with_question_text_array = []
         @questioncounters = QuestionCounter.all
         @questioncounters.each do |qc|
                @used_id_with_question_text_array << (qc.used_session_id+qc.question_text)
         end

   if @used_id_with_question_text_array.include?(request.session_options[:id]+@question.text)
         redirect_to :action => "question"
	 flash[:notice] = "STOP HITTING THE BACK BUTTON IN YOUR BROWSER! YOUR ATTEMPT TO CHEAT HAS BEEN THWARTED!"
         return
   else

         @questioncounter = QuestionCounter.new
         @questioncounter.used_session_id = request.session_options[:id]
         @questioncounter.question_text = @question.text
         @questioncounter.save





	 
	 @choice = choiceid ? Choice.find(choiceid) : nil
	 if @choice and @choice.correct
		@correct = true
		session[:correct] += 1
	 else
		@correct = false
	 end
	 
	 session[:current] += 1
   end 
  end

  def end
	 @correct = session[:correct]
	 @total   = session[:total]
	 
	 @score = @correct * 100 / @total  
  end

  def create
  end

  def destroy
  end
end
