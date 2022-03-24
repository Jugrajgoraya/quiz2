class ReviewsController < ApplicationController

    before_action :authenticate_user!
    before_action :find_idea
    def create
        @review = Review.new params.require(:review).permit(:body)
        @review.idea = @idea
        @review.user = User.find_by_id session[:user_id]
        if @review.save
            redirect_to idea_path(@idea)
        end
    end
    def destroy
        @review = Review.find params[:id]
        if can?(:crud, @review)
            @review.destroy
            redirect_to idea_path(@idea.id)
        else
            redirect_to root_path, alert: "Not Authorized! "
        end
    end
    private
    def find_idea
        @idea = Idea.find params[:idea_id]
    end
end
