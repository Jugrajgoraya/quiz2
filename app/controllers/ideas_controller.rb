class IdeasController < ApplicationController

    before_action :authenticate_user!, except: [:show, :index]
    before_action :find_idea, only: [:show, :edit, :update, :destroy]
    before_action :authorize_user!, only: [:edit, :update, :destroy]
    def new
        @idea  = Idea.new
    end
    def create
        @idea  = Idea.new params.require(:idea).permit(:title, :description)
        @idea.user = User.find_by_id session[:user_id]
        if @idea.save
            redirect_to idea_path(@idea)
        else
            render :new
        end
    end

    def show
        @review = Review.new
        @reviews = Review.all.order(created_at: :desc)
        @like = @idea.likes.find_by(user: current_user)
    end

    def index
        @ideas = Idea.all.order(created_at: :desc)
    end

    def edit
    end

    def update
        @idea.update params.require(:idea).permit(:title, :description)
        redirect_to idea_path(@idea)
    end
    
    def destroy
        @idea.destroy
        redirect_to ideas_path
    end

    private
    def find_idea
        @idea = Idea.find params[:id]
    end
    def authorize_user!
        redirect_to root_path, alert: "Not Authorized! " unless can?(:crud, @idea) 
    end
end
