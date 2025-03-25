class CommentsController < ApplicationController
  before_action :require_user
  before_action :set_comment, only: [:destroy]
  before_action :require_same_user, only: [:destroy]

  def create
    @review = Review.find(params[:review_id])
    @comment = @review.comments.build(comment_params)
    @comment.user = current_user

    if @comment.save
      redirect_to movie_path(@review.movie), notice: "回复已发布"
    else
      redirect_to movie_path(@review.movie), alert: "回复不能为空"
    end
  end

  def destroy
    movie = @comment.review.movie
    @comment.destroy
    redirect_to movie_path(movie), notice: "回复已删除"
  end

  private

  def set_comment
    @comment = Comment.find(params[:id])
  end

  def comment_params
    params.require(:comment).permit(:content)
  end

  def require_same_user
    if current_user != @comment.user && !current_user.admin?
      flash[:alert] = "您只能删除自己的回复"
      redirect_to movie_path(@comment.review.movie)
    end
  end
end