require 'rails_helper'

RSpec.describe NewsArticlesController, type: :controller do

    describe '#new' do

      it "renders a new template" do
        get(:new)
        expect(response).to(render_template(:new))
      end

      it "sets an instance variable with a new news article" do
        get(:new)
        expect(assigns(:news_article)).to(be_a_new(NewsArticle))
      end
    end

    describe "#create" do
      context "with valid parameters" do
        def valid_request
          post(:create, params: {news_article: FactoryBot.attributes_for(:news_article)})
        end
        it 'saves a new news article to the db' do
          count_before = NewsArticle.count
          valid_request
          count_after = NewsArticle.count
          expect(count_after).to eq(count_before + 1)
        end
        it 'redirects to the show page of that news article' do
          valid_request
          news_article = NewsArticle.last
          expect(response).to(redirect_to(news_article_path(news_article.id)))
        end
      end
      context "with invalid parameters" do
        def invalid_request
          post(:create, params: {news_article: FactoryBot.attributes_for(:news_article, title: nil)})
        end
        it 'does not create a news article in the db' do
          count_before = NewsArticle.count
          invalid_request
          count_after = NewsArticle.count
          expect(count_after).to eq(count_before)
        end
        it 'renders the new template' do
          invalid_request
          expect(response).to render_template(:new)
        end
  
        it 'assigns an invalid news article as an instance variable' do
          invalid_request
          expect(assigns(:news_article)).to be_a(NewsArticle)
        end
      end
    end

    describe "#show" do

      it "renders the show template" do
        news_article = FactoryBot.create(:news_article)
        get(:show, params: {id: news_article.id })
        expect(response).to render_template :show
      end
      
      it "sets @news_article for the shown object" do
          news_article = FactoryBot.create(:news_article)
        get(:show, params: {id: news_article.id })
        expect(assigns(:news_article)).to eq(news_article)
      end

    end

    describe "#destroy" do

        it 'removes the news article from the db' do
          # check amount_before amount_after of the table NewsArticles
          # if amount_after + 1 == amount_before => deleted
          news_article = FactoryBot.create(:news_article)
          delete(:destroy, params: {id: news_article.id})
          expect(NewsArticle.find_by(id: news_article.id)).to(be(nil))
        end
      
        it 'redirects to the job posts index' do
          news_article = FactoryBot.create(:news_article)
          delete(:destroy, params: {id: news_article.id})
          expect(response).to redirect_to(news_articles_url)
        end
      
        it 'sets a flash message' do
          news_article = FactoryBot.create(:news_article)
          delete(:destroy, params: {id: news_article.id})
          expect(flash[:danger]).to be
        end
    end

    describe "#index" do
      it 'renders the index template' do
        get(:index)
        expect(response).to render_template(:index)
      end
  
      it 'assigns an instance variable to all created news articles' do
        news_article_1 = FactoryBot.create(:news_article)
        news_article_2 = FactoryBot.create(:news_article)
        news_article_3 = FactoryBot.create(:news_article)
        get(:index)
        expect(assigns(:news_articles)).to eq([news_article_3, news_article_2, news_article_1])
      end
    end

    describe "#edit" do
      news_article = FactoryBot.create(:news_article)
      it 'renders the edit template' do
          get(:edit, params: {id: news_article.id })
          expect(response).to render_template :edit
      end
      it "sets @news_article for the shown object" do
          get(:edit, params: {id: news_article.id })
          expect(assigns(:news_article)).to eq(news_article)
      end
    end

    describe "#update" do
      before do
        @news_article = FactoryBot.create(:news_article)
      end
      context "with valid parameters" do
       
        it 'update the news article record with new attributes' do
          new_title = "#{@news_article.title} #{rand(1..10)}"
          patch(:update, params: {id:@news_article.id,news_article:{title:new_title} })
        end
        it 'redirects to the show page' do
          new_title = "#{@news_article.title} #{rand(1..10)}"
          patch(:update, params: {id:@news_article.id,news_article:{title:new_title} })
          expect(response).to(redirect_to(@news_article))
        end
      end
      context "with invalid parameters" do
        it "should not update the news article record" do
          patch(:update, params:{id:@news_article.id, news_article: {titile:nil}})
          updated_record = NewsArticle.find(@news_article.id)
          expect(updated_record.title).to(eq(@news_article.title))
        end
        
      end
    end
end
