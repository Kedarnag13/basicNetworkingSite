require 'open-uri'
class Member < ApplicationRecord
  has_secure_password
  has_friendship
  has_many :headings
  after_save :crawl_website
  validates :password, presence: true, length: { minimum: 8 }

  def crawl_website
    if self.original_url.present?
      begin
        doc = Nokogiri::HTML(open(self.original_url))
        doc.css('h1').each do |heading|
          Heading.create(tag_name: 'h1', heading: heading.text, member_id: self.id)
        end
        doc.css('h2').each do |heading|
          Heading.create(tag_name: 'h2', heading: heading.text, member_id: self.id)
        end
        doc.css('h3').each do |heading|
          Heading.create(tag_name: 'h3', heading: heading.text, member_id: self.id)
        end
      rescue OpenURI::HTTPError => e
        raise e.message
      end
    end
  end

end