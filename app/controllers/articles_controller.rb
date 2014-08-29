class ArticlesController < ApplicationController
  before_action :require_login, except: [:index, :show]
  before_action :require_article_owner, only: [:edit, :update, :destroy]

  def index
    @articles = Article.all
  end

  def new
    @article = Article.new
  end
   
  def create
    @article = Article.new(article_params)
   
    if @article.save
      redirect_to @article
    else
      render 'new'
    end
  end

  def show
    @article = Article.find(params[:id])
  end

  def edit
    @article = Article.find(params[:id])
  end

  def update
    @article = Article.find(params[:id])
   
    if @article.update(article_params)
      redirect_to @article
    else
      render 'edit'
    end
  end

  def destroy
    @article = Article.find(params[:id])
    @article.destroy
   
    redirect_to articles_path
  end

  private

  def article_params
    params.require(:article).permit(:title, :text).merge(user: User.find(session[:user_id]))
  end

  def require_login
    redirect_to login_path unless session[:user_id]
  end

  def require_article_owner
    user = User.find(session[:user_id])
    article = Article.find(params[:id])
    redirect_to root_path, alert: 'You may not access that article.' unless article.user == user
  end
end
