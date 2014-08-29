class CommentsController < ApplicationController
  before_action :require_login
  before_action :require_comment_owner, only: [:destroy]

  def create
    @article = Article.find(params[:article_id])
    @comment = @article.comments.create(comment_params)
    redirect_to article_path(@article)
  end

  def destroy
    @article = Article.find(params[:article_id])
    @comment = @article.comments.find(params[:id])
    @comment.destroy
    redirect_to article_path(@article)
  end
 
  private

  def comment_params
    params.require(:comment).permit(:commenter, :body).merge(user: User.find(session[:user_id]))
  end

  def require_login
    redirect_to login_path unless session[:user_id]
  end

  def require_comment_owner
    user = User.find(session[:user_id])
    comment = Comment.find(params[:id])
    redirect_to root_path, alert: 'You may not access that comment.' unless comment.user == user
  end
end
