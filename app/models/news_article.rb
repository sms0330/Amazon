class NewsArticle < ApplicationRecord
    validates(:title, presence: true, uniqueness:  true)
    validates(:description, presence: true)
    validate :published_at_after_created_at
    before_save :titleize_title
    def set_publish_time
        self.published_at = Time.now
        self.published_at
    end

    private

    def published_at_after_created_at
        # published_at created_at datetime 
        # published_at < created_at = July 14 < July 15
        if self.published_at && self.created_at && (self.published_at < self.created_at) 
            self.errors.add(:published_at,'must be after created_at')
        end
    end

    def titleize_title
        self.title = self.title.titlecase
    end
end