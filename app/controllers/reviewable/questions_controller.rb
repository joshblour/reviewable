module Reviewable
  class QuestionsController < ReviewableController
    before_filter :load_question, except: :index
    
    def index
      @questions = Question.where(true)
    end
    
    def new
    end
    
    def edit
    end
    
    def create      
      respond_with @question do |format|
        if @question.update(question_params)
          format.html { redirect_to questions_path, notice: 'Question was successfully created.' }        
        else
          format.html { render :new }
        end
      end
    end
    
    def update
      respond_with @question do |format|
        if @question.update(question_params)
          format.html { redirect_to questions_path, notice: 'Question was successfully updated.' }        
        else
          format.html { render :edit }
        end
      end
      
    end
    
    def destroy
      @question.destroy
      respond_with @question do |format|
        format.html {redirect_to questions_path, notice: 'Question was successfully destroyed.'}
      end
    end  
    
    private 
    
    def question_params
      params.require(:question).permit(:question_text, :question_type, :slug, :answer_min, :answer_max, :enabled, :answer_options_string )
    end
    
    def load_question
      if params[:id]
        @question = Question.find(params[:id])
      else
        @question = Question.new
      end
    end
    
  end
end
