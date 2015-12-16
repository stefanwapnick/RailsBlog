class ArticlesController < ApplicationController
  before_action :set_article , only: [:show, :destroy, :edit, :update]
  before_action :required_user, except: [:index, :show]
  before_action :require_same_user, only: [:edit, :update, :destroy]

  # GET - LIST ARTICLES
  ####################################################################
  def index
    @articles = Article.paginate(page: params[:page], per_page: 5)
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
    @article.user = current_user

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
  def destroy
    if @article.nil?
      render :text => 'Not Found', :status => '404'
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

    def require_same_user
      if current_user.id == @article.user.id
        flash[:danger] = 'Can only modify own articles'
        redirect_to root_path
      end
    end

end