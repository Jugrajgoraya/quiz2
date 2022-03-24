class LikesController < ApplicationController
    def create
        @user = current_user
        @idea = Idea.find params[:idea_id]
        @like = Like.new(user: @user, idea: @idea)

        if can?(:like, @idea)
            if@like.save 
                flash.notice = "Added to liked ideas"
            else
                flash.alert = @like.errors.full_messages.join(', ')
            end
        else
            flash[:notice] = "you can not add it to likes"
        end
        redirect_to ideas_path
    end
    def destroy
        @like = current_user.likes.find params[:id]
        if can?(:delete, @like)
            @like.destroy
            flash.notice = "Product removed from likes"
        else
            flash.alert = "couldn't remove from likes"
        end
        redirect_to ideas_path
    end
end
