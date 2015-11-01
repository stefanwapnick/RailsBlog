class ArticlesController < ApplicationController

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

    if @article.save
      flash[:notice] = 'Article was successfully created'
      redirect_to article_path(@article)
    else
      render :action => 'new'
    end
  end

  # GET - SHOW ARTICLE
  ####################################################################
  def show
    @article = Article.find(params[:id])
    #render plain: @article.inspect
  end

  # DELETE - DELETE ARTICLE
  ####################################################################
  def delete
    @article = Article.find(params[:id])

    if @article.nil?
      render :status => 404
    end

    if @article.destroy
      flash[:notice] = 'Article successfully deleted'
      redirect_to articles_path
    else
      flash[:notice] = 'Problem deleting article'
      render :action => 'index'
    end

  end

  # GET - EDIT ARTICLE
  ####################################################################
  def edit
    @article = Article.find(params[:id])
  end

  # POST - EDIT ARTICLE
  ####################################################################
  def update
    # Grab existing article
    @article = Article.find(params[:id])
    if @article.update(article_params)      # Update article with params passed in
      flash[:notice] = 'Article was successfully edited'
      redirect_to article_path(@article)
    else
      render :action => 'edit'
    end
  end

  private
  def article_params
    params.require(:article).permit(:title, :description)
  end

end