require 'rails_helper'

RSpec.describe NewsArticle, type: :model do
  describe "validates" do
    it("should require a title") do
      new_newsarticle = NewsArticle.new()
      new_newsarticle.valid?
      expect(new_newsarticle.errors.messages).to(have_key(:title))
    end

    it("should have a unique title") do
      persisted_na = NewsArticle.create(title: "AAAA", description: "BBBBB")
      na = NewsArticle.new(title: persisted_na.title)
      na.valid?
      expect(na.errors.messages[:title]).to(include("has already been taken"))
    end

    it("should have a description") do
      new_newsarticle =  NewsArticle.new
      new_newsarticle.valid?
      expect(new_newsarticle.errors.messages).to(have_key(:description))
    end

    it("published_at should later than created_at") do
      new_newsarticle = NewsArticle.create(title: "AAAA", description: "BBBBB", published_at: Time.now-100)
      new_newsarticle.valid?
      expect(new_newsarticle.errors.messages).to(have_key(:published_at))
    end
  end

  describe "titleized" do
    it("should save with a title in titlecase") do
      news_article = NewsArticle.create({
        title: "this is a title",
        description: "BBBBBBBBB"
      })
      expect(news_article.title).to(eq "This Is A Title")
    end
  end
  
  describe "publish" do
    it("should have #publish that publishes with the current time") do
      news_article = NewsArticle.new({
        title: "Publish me please",
        description: "Publish me please but a description"
      })
      # get the current time
      current_time =  Time.now.utc
      # call the method in the model to set published_at to current time
      # we can't use news_article.published_at = Time.now.utc
      news_article.published_at = news_article.set_publish_time
      # if this method set_publish_time works
      # it means that news_article.published_at == current_time => ture
      publish_time = news_article.published_at
      expect(publish_time.to_s).to(eq current_time.to_s)
      # expect(publish_time).to(be_within(1.seconds).of current_time)
    end
  end
end