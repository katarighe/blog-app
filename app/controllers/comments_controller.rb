class Comments Controller < ApplicationController
    layout 'standard'
    def new
      @comment = Comment.new
    end
  
    def create
      @comment = Post.new(params.require(:post).permit(:title, :text))
      @comment.user = current_user
      if @comment.save
        flash[:sucess] = 'Comment created successfuly!'
        redirect_to user_post_path(id: @comment.post_id, user_id: @comment.user_id)
      else
        flash.now[:error] = 'Error, the comment cannot be created!'
        render :new, locals: { comment: @comment }
      end
    end
  end
  