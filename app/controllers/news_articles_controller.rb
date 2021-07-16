class NewsArticlesController < ApplicationController
    before_action :find_news_article, only: [:show, :destroy, :edit, :update]
    before_action :news_article_params, only: [:create, :update]

    def new
        @news_article = NewsArticle.new
    end
    
    def create
        @news_article = NewsArticle.new news_article_params
        if @news_article.save
            redirect_to news_article_path(@news_article)
        else
            render :new
        end
    end

    def destroy
        find_news_article
        find_news_article.destroy
        flash[:danger] = "deleted news article"
        redirect_to news_articles_path
    end

    def show
        @find_news_article
    end

    def index
        @news_articles = NewsArticle.all.order(created_at: :desc)
    end

    def edit

    end

    def update
        @find_news_article
        @news_article.update news_article_params
        redirect_to @news_article
    end

    private

    def news_article_params
        params.require(:news_article).permit(:title, :description, :view_count, :published_at)
    end

    def find_news_article
        @news_article = NewsArticle.find params[:id]
    end

end
