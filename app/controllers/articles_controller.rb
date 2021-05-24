class ArticlesController < ApplicationController
  skip_before_action :authenticate_user!, only: :index, raise: false
  before_action :set_article, only: %i[show edit update]

  def index
    @articles = if params[:query]
                  article_search
                else
                  Article.published.order('updated_at DESC')
                end

  end

  def new
    @article = Article.new
  end

  def show
    @user = User.find(@article.user_id)
  end

  def edit; end

  def create
    @article = Article.new(article_params)

    respond_to do |format|
      if @article.save
        format.html { redirect_to new_otp_secret_path(@article), notice: 'Article saved as draft.' }
        format.json { render :show, status: :created, location: @article }
      else
        format.html { render :new }
        format.json { render json: @article.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    redirect_to new_otp_secret_path(article_id: @article.id, article_params: article_params), notice: 'Please confirm OTP to complete.'
  end

  def my_articles
    @articles = current_user.articles.order('updated_at DESC')
  end

  private

  def set_article
    @article = Article.find(params[:id])
  end

  def article_search
    Article.published.search_article(query: params[:query]).order('updated_at DESC')
  end

  def article_params
    params.require(:article).permit(:title, :description, :image, :body, :user_id)
  end
end
