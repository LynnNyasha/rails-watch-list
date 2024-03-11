class Movie < ApplicationRecord
  validates :title, :overview, presence: true
  has_many :bookmarks
  belongs_to :list
end
