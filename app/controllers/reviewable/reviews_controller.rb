module Reviewable
  class ReviewsController < ReviewableController
    before_filter :load_review, except: :index
    
    def index
      @reviews = Review.where(true)
    end
    
    def new
    end
    
    def edit
    end
    
    def create      
      respond_with @review do |format|
        if @review.update(review_params)
          format.html { redirect_to reviews_path, notice: 'Review was successfully created.' }        
        else
          format.html { render :new }
        end
      end
    end
    
    def update
      respond_with @review do |format|
        if @review.update(review_params)
          format.html { redirect_to reviews_path, notice: 'Review was successfully updated.' }        
        else
          format.html { render :edit }
        end
      end
      
    end
    
    def destroy
      @review.destroy
      respond_with @review do |format|
        format.html {redirect_to reviews_path, notice: 'Review was successfully destroyed.'}
      end
    end  
    
    private 
    
    def review_params
      params.require(:review).permit(results: [:question_id, :answer], results_attributes: [:question_id, :answer], :submitted_at)
    end
    
    def load_review
      if params[:id]
        @review = Review.find(params[:id])
      else
        @review = Review.new
      end
    end
    
  end
end
