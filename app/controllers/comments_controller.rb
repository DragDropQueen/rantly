class CommentsController < ApplicationController
  before_filter :require_authentication!

  def create
    create_comment_object

    if @comment.save
      redirect_to :back, notice: 'Your comment has been posted!'
    else
      redirect_to :back, notice: "Oh noes! We couldn't save your comment!"
    end
  end

  private

  def comment_params
    params.require(:comment).permit(:body).merge({user_id: @user.id})
  end

  def create_comment_object
    if params[:rant_id]
      rant = Rant.find(params[:rant_id])
      @comment = rant.comments.build(comment_params)
    else
      user = User.find(params[:user_id])
      @comment = Comment.new(comment_params.merge({commented_id: user.id, commented_type: 'User'}))
    end
  end
end