class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :omniauthable, omniauth_providers: [:google_oauth2, :facebook, :github]
  
  has_many :playlists

  def self.ransackable_attributes(auth_object = nil)
    ["avatar_url", "created_at", "email", "full_name", "id", "is_admin", "is_artist", "provider", "remember_created_at", "reset_password_sent_at", "reset_password_token", "uid"]
  end

  def self.ransackable_associations(auth_object = nil)
    ["playlists"]
  end

  def self.from_omniauth(auth)
    # Either create a User record or update it based on the provider (Google) and the UID
    where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
      # Update the User record attributes
      user.email = auth.info.email
      user.password = Devise.friendly_token[0, 20]
      user.full_name = auth.info.name   # assuming the user model has a name
      user.avatar_url = auth.info.image # assuming the user model has an image
    end
  end

end
