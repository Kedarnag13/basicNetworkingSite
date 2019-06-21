class Heading < ApplicationRecord
  belongs_to :member
  validates :heading, uniqueness: { case_sensitive: false }
end
