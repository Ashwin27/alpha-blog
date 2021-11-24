class ArticlesController < ApplicationController
  before_action :set_article, only: [:show, :edit, :update, :destroy]
  before_action :require_user, except: [:show, :index, :new]
  before_action :require_same_user, only: [:edit, :update, :delete]

  def show
  end

  def index
    @articles = Article.paginate(page: params[:page], per_page: 5).all
  end

  def new
    @article = Article.new
  end

  def create
    @article = Article.new(article_params)
    @article.user = current_user
    if @article.save
      flash[:notice] = "Article was created successfully"
      redirect_to article_path(@article.id)
    else
      render 'new'
    end
  end

  def edit
  end

  def update
    if @article.update(article_params)
      flash[:notice] = "Article was updated successfully"
      redirect_to @article
    else
      render 'edit'
    end
  end

  def destroy
    @article.destroy
    redirect_to articles_path
  end

  private

  def set_article
    @article = Article.find(params[:id])
  end

  def article_params
    params.require(:article).permit(:title, :description)
  end

  def require_same_user
    if not current_user.admin and current_user != @article.user
      flash[:alert] = "You can only edit or delete your own article"
      redirect_to @article
    end
  end

end