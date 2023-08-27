class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  
  has_one_attached :image       
  has_many :songs, dependent: :destroy
  has_many :favorites, dependent: :destroy
  has_many :comments, dependent: :destroy
  
  validates :name, presence: true
  
  def get_image
    (image.attached?) ? image : 'no_image.jpg'
  end
  
  def favorited?(user)
     favorites.where(user_id: user.id).exists?
  end
  
  def self.ransackable_attributes(auth_object = nil)
    ["created_at", "email", "encrypted_password", "id", "introduction", "is_withdrawal", "name", "remember_created_at", "reset_password_sent_at", "reset_password_token", "updated_at"]
  end
  
  def active_for_authentication?
    super && (is_withdrawal == false)
  end
  
  
  def user_status
    if is_withdrawal == true
      "退会"
    else
      "有効"
    end
  end
  
  GUEST_USER_EMAIL = "guest@example.com"
  
  def self.guest
    find_or_create_by!(email: GUEST_USER_EMAIL) do |user|
      user.password = SecureRandom.urlsafe_base64
      user.name = 'guestuser'
    end
  end
 
  def guest_user?
    email == GUEST_USER_EMAIL
  end
  
end
