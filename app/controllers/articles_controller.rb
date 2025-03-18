class ArticlesController < ApplicationController
  before_action :find_article, only: [:show, :edit, :update, :destroy]
  def index
    @articles = Article.all
  end

  def create
    @article = Article.create(article_params)
    respond_to do |formate|
      formate.turbo_stream
    end
    @articles = Article.count
  end
  def show
    @article.update(viewed: true)
  end

  def edit
    respond_to do |format|
      format.html { render partial: "form", locals: { article: @article } }
    end
  end

  def update
    @article.update(article_params)
    respond_to do |format|
      format.turbo_stream
    end
  end

  def destroy
    @article.destroy
    respond_to do |format|
      format.turbo_stream
    end
    @articles = Article.count
  end

  private

  def article_params
    params.require(:article).permit(:title, :content)
  end

  def find_article
    @article = Article.find(params[:id])
  end
  
end
