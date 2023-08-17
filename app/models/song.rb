class Song < ApplicationRecord
  belongs_to :genre
  belongs_to :user
  has_many :favorites, dependent: :destroy
  has_many :comments, dependent: :destroy

  def favorited?(user)
    favorites.where(user_id: user.id).exists?
  end

  def self.ransackable_associations(auth_object = nil)
    ["comments", "favorites", "genre", "user"]
  end

  def self.ransackable_attributes(auth_object = nil)
    ["body", "created_at", "genre_id", "id", "title", "updated_at", "user_id"]
  end

end
