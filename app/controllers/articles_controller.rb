class ArticlesController < ApplicationController

  before_action :set_article , only: [:show, :delete, :edit, :update]

  # GET - LIST ARTICLES
  ####################################################################
  def index
    @articles = Article.all
  end


  # GET - NEW ARTICLE
  ####################################################################
  def new
    @article = Article.new
  end

  # POST - NEW ARTICLE
  ####################################################################
  def create
    @article = Article.new(article_params)
    @article.user = User.first

    if @article.save
      flash[:success] = 'Article was successfully created'
      redirect_to article_path(@article)
    else
      render :action => 'new'
    end
  end

  # GET - SHOW ARTICLE
  ####################################################################
  def show
    #render plain: @article.inspect
  end

  # DELETE - DELETE ARTICLE
  ####################################################################
  def delete
    if @article.nil?
      render :status => 404
    end

    if @article.destroy
      flash[:success] = 'Article successfully deleted'
      redirect_to articles_path
    else
      flash[:warning] = 'Problem deleting article'
      render :action => 'index'
    end

  end

  # GET - EDIT ARTICLE
  ####################################################################
  def edit
  end

  # POST - EDIT ARTICLE
  ####################################################################
  def update
    if @article.update(article_params)      # Update article with params passed in
      flash[:success] = 'Article was successfully edited'
      redirect_to article_path(@article)
    else
      render :action => 'edit'
    end
  end

  private
    def set_article
      @article = Article.find(params[:id])
    end

    def article_params
      params.require(:article).permit(:title, :description)
    end

end