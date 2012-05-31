class Page < ActiveRecord::Base
  attr_accessible :content, :published_on, :title

  validates_presence_of :title, :content
  validates_uniqueness_of :title

  scope :published, where('published_on IS NOT NULL')
  scope :unpublished, where('published_on IS NULL')

  def count_words
    scan_words(title, content)
  end

  def publish
    self.published_on = Time.now
    self.save
  end

  private

    def scan_words(*strings)
      strings.reduce(0) { |n, string| string.scan(/\w+/).size + n }
    end
end
