class QuestionsController < ApplicationController
before_filter :authenticate_user!
  before_filter do 
    redirect_to home_index_path unless current_user && current_user.admin?
  end


def index
  @questions = Question.all
  @questions.sort! {|a,b| a.text <=> b.text}
  @alcolyte_questions = @questions.where("question_type = 'alcolyte'")
  @maester_questions = @questions.where("question_type = 'maester'")
  @archmaester_questions = @questions.where("question_type = 'archmaester'")
end
def new
  @question = Question.new
end
def create
  questions_params = params.require('question').permit(:text, :question_type)  
  @question = Question.new(questions_params)

  if @question.save
    redirect_to(@question, :notice => 'Question was successfully created.')
  else
    render :action => "new"
  end
end
def update
  questions_params = params.require('question').permit(:text, :question_type)
  
  @question = Question.find(params[:id])
  
  if @question.update_attributes(questions_params) 
     redirect_to(@question, :notice => 'Question was successfully updated.')
  else
     render :action => "edit"
  end
end

def show
  @question = Question.find(params[:id])
end  
def edit
  @question = Question.find(params[:id])
end
def destroy
    @question = Question.find(params[:id])
    @question.destroy
    redirect_to(questions_path)
end
end
