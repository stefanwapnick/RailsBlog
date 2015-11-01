class ArticlesController < ApplicationController




  # GET - NEW ARTICLE
  def new
    puts 'TEST 1 TEST 1 TEST 1 TEST 1 TEST 1 TEST 1'
    @article = Article.new
  end

  # POST - NEW ARTICLE
  def create
    puts 'TEST 2 TEST 2 TEST 2 TEST 2 TEST 2 TEST 2'
    @article = Article.new(article_params)

    if @article.save
      flash[:notice] = 'Article was successfully created'
      redirect_to article_path(@article)
    else
      render :action => 'new'
    end

  end

  def show
    #puts 'TEST 3 TEST 3 TEST 3 TEST 3'
    @article = Article.find(params[:id])
    #render plain: @article.inspect
  end

  private
  def article_params
    params.require(:article).permit(:title, :description)
  end

end