require 'rails_helper'

RSpec.describe NewsArticlesController, type: :controller do
    describe "#new" do
        it "renders the new template" do
            get(:new)
        end

        it "sets an instance variable with a new news_article" do
            get(:new)
            expect(assigns(:news_article)).to(be_a_new(NewsArticle))
        end
    end

    describe "#create" do
        context "with valid parameters" do
            def valid_request
                post(:create, params: { news_article: FactoryBot.attributes_for(:news_article)})
            end
            it "creates a news article in the database" do
                count_before = NewsArticle.count 
                valid_request
                count_after = NewsArticle.count
                expect(count_after).to(eq(count_before + 1))
            end

            it "redirects us to the show page for the new instance of news article" do
                valid_request
                news_article = NewsArticle.last
                expect(response).to(redirect_to(news_article_url(news_article.id)))
            end
        end
        context "with invalid parameters" do
            def invalid_request
                post(:create, params: { news_article: FactoryBot.attributes_for(:news_article, title:nil)})
            end

            it "does not save a record in the database" do
                count_before = NewsArticle.count
                invalid_request
                count_after = NewsArticle.count
                expect(count_after).to(eq(count_before))
            end

            it "renders the new template" do
                invalid_request
                expect(response).to render_template(:new)
            end
        end
    end

    describe "#destroy" do
        before do 
            @news_article = FactoryBot.create(:news_article)
            delete(:destroy, params: { id: @news_article.id })
        end

        it "should remove a news article from the database" do
            expect(NewsArticle.find_by(id: @news_article.id)).to be(nil)
        end

        it "redirects to the news articles index" do
            expect(response).to redirect_to(news_articles_path)
        end

        it "sets a flash message that it was deleted" do
            expect(flash[:danger]).to be
        end
    end

    describe "#show" do
        it "render the show template" do
            news_article = FactoryBot.create(:news_article)
            get(:show, params: { id: news_article.id })
            expect(response).to render_template(:show)
        end

        it "sets an instance variable @news_article for the shown object" do
            news_article = FactoryBot.create(:news_article)
            get(:show, params: { id: news_article.id })
            expect(assigns(:news_article)).to eq(news_article)
        end
    end

    describe "#index" do
        it "renders the index template" do
            get(:index)
            expect(response).to render_template(:index)
        end

        it "assigns an instance variable @news_articles which contains all the created news articles" do
            news_article_1 = FactoryBot.create(:news_article)
            news_article_2 = FactoryBot.create(:news_article)
            news_article_3 = FactoryBot.create(:news_article)
            get(:index)
            expect(assigns(:news_articles)).to eq([news_article_3, news_article_2, news_article_1])
        end
    end


    describe "#edit" do
        it "renders the edit template" do
            news_article = FactoryBot.create(:news_article)
            get(:edit, params: { id: news_article.id })
            expect(response).to render_template :edit
        end
    end

    describe "#update" do
        before do 
            @news_article = FactoryBot.create(:news_article)
        end

        context "with valid parameters" do
            it "updates the news article record with new attributes" do
                new_title = "#{@news_article.title} Plus Some Changes!"
                patch(:update, params: {id: @news_article.id, news_article: { title: new_title }})
                expect(@news_article.reload.title).to eq (new_title)
            end

            it "redirects to the show page of updated news article" do
                new_title = "#{@news_article.title} Plus some changes!"
                patch(:update, params: {id: @news_article.id, news_article: { title: new_title }})
                expect(response).to redirect_to(@news_article)
            end
        end

        context "with invalid parameters" do

            it "should not update the news article record" do
              patch(:update, params: { id: @news_article.id, news_article: { title: nil }})
              news_article_after_update = NewsArticle.find(@news_article.id)
              expect(news_article_after_update.title).to eq @news_article.title
            end
      
          end
    end

end