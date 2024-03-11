class List < ApplicationRecord
  validates :name, uniqueness: true, presence: true

  has_many :bookmarks, dependent: :destroy
  has_many :movies, through: :bookmarks

  # created by has_many method
  # def movies
  #   Movie.joins(:bookmarks).where("bookmarks.list_id = self.id")
  # end
end
