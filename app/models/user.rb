class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :confirmable, :registerable,
         :recoverable, :rememberable, :validatable, :trackable, :lockable,
         :omniauthable, omniauth_providers: %i[facebook google_oauth2]
  before_save :downcase_email

  def self.from_omniauth(auth)
    result = User.where(email: auth.info.email).first
    return result if result.present?

    where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
      user.email = auth.info.email
      user.password = Devise.friendly_token[0, 20]
      user.provider = auth.provider
      user.uid = auth.uid
      user.first_name = auth.info.first_name
      user.last_name = auth.info.last_name
      user.photo_url = auth.info.image
      user.skip_confirmation!
    end
  end

  def downcase_email
    self.email = email.downcase
  end

  def full_name
    "#{last_name} #{first_name}"
  end
end
