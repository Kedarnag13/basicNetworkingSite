require 'open-uri'
class Member < ApplicationRecord
  before_save :crawl_website

  def crawl_website
    doc = Nokogiri::HTML(open(self.original_url))
    doc.css('h1').each do |heading|
      p heading.text
    end
  end

end