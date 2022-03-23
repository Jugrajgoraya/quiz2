class IdeasController < ApplicationController

    before_action :find_idea, only: [:show, :edit, :update, :destroy]
    def new
        @idea  = Idea.new
    end
    def create
        @idea  = Idea.new params.require(:idea).permit(:title, :description)
        if @idea.save
            redirect_to idea_path(@idea)
        else
            render :new
        end
    end
    
    def show
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
end
