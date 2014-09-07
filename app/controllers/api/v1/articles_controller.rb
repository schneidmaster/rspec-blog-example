class Api::V1::ArticlesController < ApplicationController
  def index
    render json: Article.all
  end

  def show
    render json: Article.find(params[:id])
  end
end