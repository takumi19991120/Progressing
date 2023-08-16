class Song < ApplicationRecord
  belongs_to :genre
  belongs_to :user
  has_many :favorites, dependent: :destroy
  has_many :comments, dependent: :destroy

def favorited?(user)
   favorites.where(user_id: user.id).exists?
end

end
